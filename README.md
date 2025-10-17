# Automated Media File Sorter ✨

A powerful Bash script that intelligently organizes thousands of photos, videos, and other files into a clean, chronological directory structure (`YYYY/MM-Month/DD-MM-YYYY`). This script was born from a personal need to tame a chaotic collection of digital media and turn it into a browsable, organized library.

See how it works below:
![Screen recording of a bash script in action. The video shows a user running the script in a terminal, providing a path to a folder, and the script then automatically moves all files into chronologically sorted folders.](https://www.valerkahere.com/assets/videos/sorter__demo-production-nomusic.mp4)

The Format of sorting depends on the branch, but generally it is:
Format:
2025 > 05-May > 01-05-2025 > photos/videos

MOVED
```text
├── 2025
│   └── 01-January
│   └── ...
│   ├── 12-December
│   │   ├── 01-12-2025
│   │   │   └── photos
│   │   │   └── videos
```

OR
```text
MOVED
└── 2025
    ├── 01-January
    │   └── 01-01-2025
    │       ├── photos
    │       └── videos
    ├── 02-February
    │   └── ...
    └── ...
```



## The Problem

Digital photo and video collections often become a mess of randomly named files spread across countless folders. Manually sorting this is tedious, time-consuming, and prone to error. This project solves that problem with a "fire-and-forget" script that does all the heavy lifting for you.

## Features

-   **Metadata-Driven Sorting:** Leverages the powerful `ExifTool` to read the "Date/Time Original" metadata embedded in media files, ensuring perfect chronological accuracy.
-   **Fallback to File Modification Date:** If a file has no EXIF data, the script intelligently falls back to the file's last modified date.
-   **Safe & Interactive:** The script operates in a non-destructive way by first moving all files to a temporary `./MOVED` directory. It also uses user prompts to confirm actions before proceeding, preventing accidental data loss.
-   **Multi-Branch Functionality:** The repository is structured with different branches for various use cases, allowing for stable versions and new feature development.
-   **Broad File Support:** Handles a wide range of common image, video, and document file extensions.

## Branch Guide

This repository contains multiple branches, each serving a different purpose. For the best experience, please use the `touse2` branch.

-   🌳 **`touse2` (Recommended):** The most up-to-date and feature-rich version. This branch includes the most robust sorting logic, user prompts, and error-handling.
-   🌿 **`touse1`:** A previous stable version with a simpler, file-extension-based sorting logic.
-    mainline **`main`:** The original proof-of-concept script. Not recommended for general use.

## Prerequisites

-   A Linux/Unix-like environment (tested on Ubuntu, should work on macOS).
-   **`ExifTool`** must be installed. This is the core dependency for reading file metadata.

## Installation & Setup

1.  **Clone the recommended branch of this repository:**
    ```bash
    git clone --branch touse2 https://github.com/valerkahere/sorter.git
    ```

2.  **Navigate into the project directory:**
    ```bash
    cd sorter
    ```

3.  **Install ExifTool:**
    *(On Debian/Ubuntu)*
    ```bash
    sudo apt-get update && sudo apt-get install libimage-exiftool-perl
    ```
    *(For other systems, please see the official [ExifTool installation guide](https://exiftool.org/install.html).)*

4.  **Make the script executable:**
    ```bash
    chmod +x your-script-name.sh
    ```
    *(Replace `your-script-name.sh` with the actual name of your script file.)*

## How to Use

1.  Run the script from your terminal:
    ```bash
    ./your-script-name.sh
    ```
2.  The script will prompt you to enter the **full path** of the source directory containing the files you want to sort.
3.  Follow the on-screen prompts to confirm the sorting process.
4.  The script will create a temporary `./MOVED` directory, move all files into it, and then sort them into a clean `YYYY/MM-Month/DD-MM-YYYY` structure within that folder.

## How It Works

1.  **Safety First:** The script creates a `MOVED` directory in your source folder. It then recursively finds all files (ignoring the `MOVED` folder itself) and moves them into this temporary location. This ensures the original directory structure is not altered and the script operates in a contained way.
2.  **Sorting Logic:** Inside the `MOVED` directory, `ExifTool` is called to read the metadata of each file. It then renames the parent directory of each file based on its creation date, effectively sorting it into the desired folder structure.
3.  **User Control:** The script asks for confirmation before major steps and at the end, giving you the option to revert the changes if needed.

## License

Licensed under the EUPL version 1.2.
See the full text in the **[LICENSE](https://github.com/valerkahere/sorter/blob/main/LICENSE)** file included in this repository or at [https://choosealicense.com/](https://choosealicense.com/licenses/eupl-1.2/#)
