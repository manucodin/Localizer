# Localizer
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/manucodin/Localizer/main.yml?label=Testing&logo=GitHub&style=for-the-badge) ![Swift Version](https://img.shields.io/badge/Swift-5.5-blue?style=for-the-badge&logo=swift) ![Platform](https://img.shields.io/badge/Platform-macOS-orange?style=for-the-badge&logo=apple) ![Mint](https://img.shields.io/badge/Mint-darkgreen?logo=leaflet&logoColor=white&style=for-the-badge) ![Homebrew](https://img.shields.io/badge/Homebrew-orange?logo=Homebrew&logoColor=white&style=for-the-badge)


Localizer is a simple tool for search your strings not localized in your project.

## Installation

### From Source

````
$ git clone https://github.com/manucodin/Localizer.git
$ cd Localizer
$ make
````
### 🌱 With [Mint](https://github.com/yonaskolb/Mint)
````
$ mint install manucodin/Localizer localizer
````
### 🍺 With [Homebrew](https://brew.sh/index_es)
````
$ brew tap manucodin/localizer https://github.com/manucodin/Localizer.git
$ brew install localizer
````

### Using Localizer

To launch the tool, only write in your terminal (-h if you want see a list with subcommands):
````
$ localizer compare -l <Your localizables path> -s <Path to search localizables> -u <Show unlocalized keys>
````
You can user the flag ````-v```` to show all output or only the strings unlocalized number

If you want ignore some keys, you can create a file named ````.localizerignore```` and add these keys in that file with this format

````
"key1"
"key2"
...
````

###### ❤️ Support

If you want to support this project, you can do some of these
1. Press ⭐️. It's a great sign that Localizer is useful
2. Share the project 🌍 somewhere with anybody

If you have any questions or feature requests, feel free to open a discussion or an issue.
