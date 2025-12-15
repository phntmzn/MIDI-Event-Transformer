# MIDI Event Transformer

A SwiftUI application for applying real-time transformations to MIDI events using customizable rules.

---

## Features

- Real-time MIDI input and output handling
- Apply transformation rules such as transposition, velocity scaling, or channel mapping
- Visualize transformed notes in SwiftUI
- Logging of received and transformed MIDI events
- Modular architecture: MIDI, Transform, Views, Utilities

---

## Project Structure

```
MIDITransformer/
├── MIDI/
│   └── MIDIManager.swift          # Handles MIDI input/output
├── Transform/
│   └── RuleEngine.swift           # Applies transformation rules to MIDI events
├── Views/
│   └── TransformerView.swift      # SwiftUI interface to visualize and apply transformations
└── Utilities/
    └── Logger.swift               # Logging helper for MIDI events and transformations
```

---

## Usage

### Initialize MIDI Manager and Rule Engine
```swift
let midiManager = MIDIManager()
let ruleEngine = RuleEngine()
```

### Handle Incoming Notes and Apply Rules
```swift
midiManager.onNoteReceived = { note, velocity, channel in
    Logger.logNote(note: note, velocity: velocity, channel: channel)
    ruleEngine.apply(note: note, velocity: velocity, channel: channel)
}

ruleEngine.onTransformed = { note, velocity, channel in
    Logger.logTransformed(note: note, velocity: velocity, channel: channel)
    midiManager.sendNote(note: note, velocity: velocity, channel: channel)
}
```

### SwiftUI View
```swift
TransformerView() // Visualizes and controls transformation rules
```

---

## Roadmap

- Support complex rule chains for MIDI events
- Real-time visual feedback of transformations
- Save and load transformation presets
- Integration with external MIDI devices

---

## License

MIT License

Real-time MIDI event transformation and visualization using Swift and SwiftUI.
