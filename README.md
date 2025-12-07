# sl-racesystem

A modular and object-agnostic racing system for Second Life, written in LSL.

This project provides a complete race track architecture using a single linked object (start line, checkpoints, finish line, and scoreboard) plus a lightweight attachable racer tag for players. It supports up to 10 racers per race and is designed to be performant, extensible, and easy to customize.

---

## ✨ Features

- Supports up to 10 racers in a single race
- Single linked track object (start, checkpoints, finish, scoreboard)
- Object-agnostic: any vehicle or attachment can be used
- Detached racer tag attached to the avatar
- Ordered checkpoints validation
- Centralized race control (root prim)
- Real-time ranking and scoreboard
- Optimized communication using `llMessageLinked`
- Simple and clean LSL architecture

---

## 🧱 System Architecture

The system is composed of two main parts:

### 1. Track Linkset (Single Object)

- Root prim: race controller and state manager
- Start line prim
- Multiple checkpoint prims
- Finish line prim
- Scoreboard prim (optional)

All track elements are linked and communicate internally using `llMessageLinked`.

### 2. Racer Tag (Attachable Object)

- Attached to the avatar
- Stores player-specific data (vehicle name, color)
- Tracks checkpoints and race time
- Communicates with the track using a private region channel

---

## 🔌 Communication Model

- Internal track communication: `llMessageLinked`
- Racer ↔ Track communication: private region channel
- Centralized event-driven logic on the root prim

---

## 🏁 Race Flow

1. Player attaches the racer tag and configures vehicle data
2. Player joins the race
3. Race starts at the start line
4. Player progresses through ordered checkpoints
5. Player crosses the finish line
6. Final ranking is calculated and displayed

---

## ⚙️ Configuration

Key values can be configured in the scripts:
- Maximum number of racers
- Total checkpoints
- Communication channel
- Scoreboard display format

---

## 📦 Installation

1. Rez all track prims in-world
2. Link all track parts into a single object
3. Place the controller script in the root prim
4. Assign checkpoint IDs to each checkpoint prim
5. Distribute the racer tag object to players

---

## 🧪 Status

This project is under active development.
APIs and internal structures may evolve.

---

## 📄 License

This project is licensed under the MIT License.
