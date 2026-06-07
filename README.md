# FFmpeg DaVinci Converter

A streamlined workflow automation tool for converting OBS recordings into DaVinci Resolve-compatible formats on Linux. This project bridges the gap between OBS QuickSync recording and DaVinci Resolve's codec requirements.

## Overview

**FFmpeg DaVinci Converter** automates the transcoding process from OBS MKV recordings (QuickSync HEVC) to DNxHR MOV files that are fully compatible with DaVinci Resolve Free on Linux. This eliminates codec limitations and ensures seamless video editing without quality loss.

## Features

✨ **Automated Transcoding** - Convert OBS recordings to Resolve-friendly formats with a single command  
🎬 **DNxHR Codec Support** - Uses industry-standard intermediate codec for professional editing  
🐚 **Fish Shell Integration** - Custom shell function for quick, intuitive conversion  
🔧 **FFmpeg-Based** - Leverages the powerful FFmpeg library for reliable, lossless conversion  
📦 **MKV to MOV** - Handles containerization from MKV (crash-safe) to MOV (edit-friendly)  

## Quick Start

### Prerequisites

- **FFmpeg** - Ensure FFmpeg is installed and in your PATH
- **Fish Shell** - The automation function is designed for Fish shell (or adapt to your shell)
- **Linux** - Tested on Linux systems

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/AsithaKanchana1/ffmpeg_conv_Davinci-.git
   cd ffmpeg_conv_Davinci-
   ```

2. **Set up the Fish shell function:**
   ```bash
   cp resolve_convert.fish ~/.config/fish/functions/
   ```

3. **Verify installation:**
   ```bash
   resolve_convert --help
   ```

## Usage

### Basic Command

Convert a single OBS recording:

```bash
resolve_convert my_recording.mkv
```

This generates `my_recording_edit.mov`, ready for DaVinci Resolve.

### Manual FFmpeg Command

If you prefer not to use the Fish shell function:

```bash
ffmpeg -i input_recording.mkv -map 0 -c:v dnxhd -profile:v dnxhr_sq -c:a pcm_s16le output_editing.mov
```

### Command Parameters

- `-i input_recording.mkv` - Input file (OBS recording)
- `-map 0` - Maps all streams from input
- `-c:v dnxhd` - Video codec (DNxHD)
- `-profile:v dnxhr_sq` - DNxHR quality profile (SQ = Standard Quality)
- `-c:a pcm_s16le` - Audio codec (PCM 16-bit)
- `output_editing.mov` - Output file (Resolve-compatible)

## Recording Settings (OBS)

For optimal results, configure OBS with these settings before recording:

**Settings > Output > Recording (Advanced Mode)**

| Setting | Value | Notes |
|---------|-------|-------|
| Recording Format | MKV | Crash-safe format |
| Video Encoder | QuickSync HEVC or H.264 | Uses Intel media engine |
| Audio Encoder | PCM (pcm_s16le or 32-bit float) | Critical: prevents muted audio in Resolve |

## Workflow

```
OBS Recording (MKV + QuickSync HEVC)
         ↓
FFmpeg DaVinci Converter (Transcoding)
         ↓
DNxHR MOV Output
         ↓
Import to DaVinci Resolve
```

## Technical Details

### Why DNxHR?

- **Resolve Compatibility** - Natively supported by DaVinci Resolve (Free version)
- **Professional Quality** - Intermediate codec standard in film/video production
- **No Proprietary Codecs** - Avoids licensing issues on Linux
- **Efficient Editing** - Optimized for timeline performance

### Audio Handling

- Converts QuickSync audio to PCM 16-bit
- Prevents silent audio issues in Resolve
- Maintains full fidelity

## Compatibility

- ✅ Linux (tested on Ubuntu 20.04+, Fedora, etc.)
- ✅ DaVinci Resolve Free (Linux)
- ✅ OBS Studio
- ✅ Fish Shell 3.0+
- ⚠️ macOS/Windows: Adapt the Fish function to Bash/Zsh

## Troubleshooting

| Issue | Solution |
|-------|----------|
| FFmpeg not found | Install FFmpeg: `sudo apt install ffmpeg` (Ubuntu/Debian) or `sudo dnf install ffmpeg` (Fedora) |
| Fish function not loading | Ensure file is in `~/.config/fish/functions/` and named correctly |
| Silent audio in Resolve | Verify OBS audio encoder is set to PCM (not AAC or MP3) |
| Slow conversion | Use `-profile:v dnxhr_hq` for higher quality (slower) or `-profile:v dnxhr_lb` for faster conversion |

## Performance Tips

- **Faster Conversion:** Use `dnxhr_lb` (Low Bitrate) profile
- **Higher Quality:** Use `dnxhr_hq` (High Quality) profile
- **SSD Storage:** Store input and output files on SSD for optimal speed

## File Structure

```
ffmpeg_conv_Davinci-/
├── README.md                    # Project documentation
├── resolve_convert.fish         # Fish shell function
└── examples/
    └── sample_workflow.md       # Workflow examples
```

## Contributing

Contributions are welcome! Feel free to:
- Report issues
- Suggest improvements
- Submit pull requests
- Share workflow tips

## License

This project is provided as-is for educational and professional use.

## References

- [FFmpeg Documentation](https://ffmpeg.org/documentation.html)
- [DaVinci Resolve Free](https://www.blackmagicdesign.com/products/davinciresolve/)
- [OBS Studio](https://obsproject.com/)
- [Fish Shell Documentation](https://fishshell.com/docs/current/)

## Support

For issues, questions, or suggestions, please open an [issue on GitHub](https://github.com/AsithaKanchana1/ffmpeg_conv_Davinci-/issues).

---

**Happy editing!** 🎥✂️

Last updated: June 2026
