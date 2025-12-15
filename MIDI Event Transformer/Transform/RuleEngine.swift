import Foundation

/// RuleEngine
/// Applies transformation rules to MIDI events in real-time
final class RuleEngine {

    /// Number of semitones to transpose notes
    var transpose: Int = 0

    /// Callback after transforming a MIDI note
    var onTransformed: ((UInt8, UInt8, UInt8) -> Void)?

    /// Apply transformation rules to an incoming MIDI note
    /// - Parameters:
    ///   - note: original MIDI note number
    ///   - velocity: note velocity
    ///   - channel: MIDI channel
    func apply(note: UInt8, velocity: UInt8, channel: UInt8) {
        let transformedNote = UInt8(Int(note) + transpose)
        onTransformed?(transformedNote, velocity, channel)
    }
}

// Example usage
let engine = RuleEngine()
engine.transpose = 2
engine.onTransformed = { note, velocity, channel in
    print("Transformed note: \(note), velocity: \(velocity), channel: \(channel)")
}
engine.apply(note: 60, velocity: 100, channel: 0) // 60 -> 62
