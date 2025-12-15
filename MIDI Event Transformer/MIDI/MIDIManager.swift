import Foundation
import CoreMIDI

/// MIDIManager
/// Handles MIDI input/output for the MIDI Event Transformer app
final class MIDIManager {

    private var midiClient = MIDIClientRef()
    private var inputPort = MIDIPortRef()
    private var outputPort = MIDIPortRef()

    /// Callback for received MIDI notes (note, velocity, channel)
    var onNoteReceived: ((UInt8, UInt8, UInt8) -> Void)?

    init(clientName: String = "MIDIEventTransformerClient") {
        MIDIClientCreate(clientName as CFString, nil, nil, &midiClient)
        MIDIInputPortCreate(midiClient, "InputPort" as CFString, midiReadCallback, Unmanaged.passUnretained(self).toOpaque(), &inputPort)
        MIDIOutputPortCreate(midiClient, "OutputPort" as CFString, &outputPort)

        for i in 0..<MIDIGetNumberOfSources() {
            MIDIPortConnectSource(inputPort, MIDIGetSource(i), nil)
        }
    }

    private let midiReadCallback: MIDIReadProc = { packetList, refCon, _ in
        guard let refCon else { return }
        let manager = Unmanaged<MIDIManager>.fromOpaque(refCon).takeUnretainedValue()
        var packet = packetList.pointee.packet

        for _ in 0..<packetList.pointee.numPackets {
            let note = packet.data.1
            let velocity = packet.data.2
            let channel = packet.data.0 & 0x0F

            manager.onNoteReceived?(note, velocity, channel)

            packet = MIDIPacketNext(&packet).pointee
        }
    }

    /// Send a MIDI note to the first available destination
    func sendNote(note: UInt8, velocity: UInt8, channel: UInt8 = 0) {
        var packet = MIDIPacket()
        packet.timeStamp = 0
        packet.length = 3
        packet.data.0 = 0x90 | channel
        packet.data.1 = note
        packet.data.2 = velocity

        var packetList = MIDIPacketList(numPackets: 1, packet: packet)
        if MIDIGetNumberOfDestinations() > 0 {
            MIDISend(outputPort, MIDIGetDestination(0), &packetList)
        }
    }
}

// Example usage
let midiManager = MIDIManager()
midiManager.onNoteReceived = { note, velocity, channel in
    print("Received note: \(note), velocity: \(velocity), channel: \(channel)")
}
