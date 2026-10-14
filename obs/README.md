# OBS: Jeff's Desk

Recording setup for lecture videos (Slides, VS Code, Excalidraw, face circle). Settled
2026-10-09 with Virgil; the reasoning is here so we don't re-derive it.

## Import
The playbook's `obs` role does this (quit OBS first): it seeds the profile and scene collection
if missing, makes Jeff's Desk the active profile, and pins the recording folder and the scenes'
image paths from `ansible/group_vars/all/paths.yml`. By hand instead: Scene Collection → Import →
`scenes/jeffs-desk.json`, Profile → Import → `profiles/`.
Then re-pick camera and mic, and install the background-removal plugin (royshil's
`obs-backgroundremoval` .pkg, v1.4.1 from its GitHub releases; drop it in `third-party/`, which
git ignores). The `camera.` and `Jeff` sources already carry its filter; it wakes up
once the plugin is in.

## Settings (Output → Advanced)
| Setting | Value | Why |
|---|---|---|
| Format | MKV | Crash-safe, DaVinci reads it, VLC scrubs long files. (Fragmented MP4/MOV is an equal alternative.) |
| Resolution | 1920×1080 canvas and output, no rescale | Webcam tops out at 1080. The old profile was quietly scaling to 720p. |
| FPS | 30 | 60 halves the per-frame budget at the same bitrate, so more smear on scrolling text. The webcam can't do 60 at 1080 anyway. |
| Video encoder | Apple VT H.264 hardware | Runs on the media engine, so it costs about zero CPU. Not x264 (software). |
| Bitrate | 6–10K kbps, ABR | See the scroll test below. |
| Keyframe | 1 s | Smoother scrubbing in DaVinci, and lossless cuts land within a second of the mark. |
| Audio | AAC 256 via CoreAudio | Barely bigger than 160, gives headroom for processing. |
| Split by size | Off | |

Desktop audio is a **source**, not a setting: + → macOS Audio Capture → Desktop Audio (or
Application Audio for one app). Put it on its own track, separate from the mic.

## Bitrate, the mental model
Resolution is the graph paper. Bitrate is the budget for describing what changed. **Change is the
demand, bitrate is the budget.** A static slide is almost free. Fast scrolling in code is the
expensive moment. Bitrate doesn't load the processor; it only changes quality and file size:
about **2.8 GB/hr at 6K, 4.6 GB/hr at 10K**.

The MKV is the master and never gets uploaded. Export for upload from DaVinci, where you set
those settings separately. So record generously and export lean.

## What actually costs performance (heaviest first)
1. Background removal: an AI model on every frame. If there's lag, change this first, not the bitrate.
   Robust Video Matting is worth testing.
2. Screen capture plus browser tabs (Slides and Excalidraw are Chrome's cost).
3. VS Code, unless an extension is pegging the CPU.

Check it for real: Docks → Stats while recording in the actual lecture setup. "Frames missed due to
rendering lag" and "Skipped frames due to encoding lag" should stay at 0 for 10 minutes.

## After recording
- **VLC:** quick playback and scrubbing.
- **LosslessCut:** clip segments out of a long MKV without re-encoding (or
  `ffmpeg -ss 00:10:00 -to 00:20:00 -i in.mkv -c copy out.mkv`). Cuts snap to keyframes.
- **DaVinci Resolve:** the edit and the export.

## Still open
- **Scroll test:** record 30 s of fast scrolling in VS Code at 6K and watch it full screen. If it's
  crisp, keep 6K. If it smears, go to 10K.
- **BlackHole:** commented out in the Brewfile until macOS Audio Capture proves it covers desktop audio.
