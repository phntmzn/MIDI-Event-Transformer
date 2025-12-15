

import Foundation

/// Logger
/// Utility for logging MIDI events and transformations
struct Logger {

    /// Log a custom message
    static func log(_ message: String) {
        print("[MIDITransformer] \(message)")
    }

    /// Log a received MIDI note
    static func logNote(note: UInt8, velocity: UInt8, channel: UInt8) {
        print("[MIDITransformer] Received Note - Note: \(note), Velocity: \(velocity), Channel: \(channel)")
    }

    /// Log a transformed MIDI note
    static func logTransformed(note: UInt8, velocity: UInt8, channel: UInt8) {
        print("[MIDITransformer] Transformed Note - Note: \(note), Velocity: \(velocity), Channel: \(channel)")
    }
}

// Example usage
Logger.log("MIDI Transformer Logger initialized")
Logger.logNote(note: 60, velocity: 100, channel: 0)
Logger.logTransformed(note: 62, velocity: 100, channel: 0)