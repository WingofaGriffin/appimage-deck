# AppImage Deck

A tool to install potentially useful AppImages to your Steam Deck's desktop.

## Why?

By default, Steam Deck uses [Flatpaks](https://flatpak.org/) as the main method of installing utilities to desktop mode. Flatpaks unfortunately tend to have the issue of having extreme limitations when it comes to interacting outside their own sandboxed instance.

While this is actually a benefit in most use cases, there are times where you want your applications to be able to interact with your greater system. This is solvable with either knowledge of the command line, or use of third party tools to modify the bounds of said sandbox, but this takes effort.

[AppImages](https://appimage.org/) on the other hand do not share these same issues. While still secure and sandboxed, they play a lot better with the Linux filesystem out of the box without any need for modification. Paired with their extreme simplicity and portability (one application is one file), this makes them an excellent candidate for some more complex apps Deck users might want to enjoy.

Some examples of this I personally have noticed are:
- Firefox and other browsers being able to interact with [SGDBoop](https://www.steamgriddb.com/boop)
- VSCodium being able to access other files in the filesystem for editing

among others. I then decided to make this tool to make installing and keeping these AppImages updated as streamlined as possible, as they lack the convenience of using the Discover store to centralize updates.

If you want to read more, here's a pretty solid explanation of the difference between Flatpak and AppImage: [Link](https://dev.to/bearlike/flatpak-vs-snaps-vs-appimage-vs-packages-linux-packaging-formats-compared-3nhl)

## Included Applications

- [Discord](https://discord.com/) - all-in-one voice and text chat application
- [Firefox](https://www.mozilla.org/en-US/firefox/) - open source graphical web browser
- [LibreOffice](https://www.libreoffice.org/) - Open Source personal productivity suite (Fresh Release Channel)
- [OnlyOffice](https://www.onlyoffice.com/) - Office suite that combines text, spreadsheet and presentation editors.
- [Thunderbird](https://www.thunderbird.net/en-US/) - Open source email, news, and chat client
- [Ungoogled Chromium](https://ungoogled-software.github.io/) - Google Chromium, sans integration with Google
- [VSCodium](https://vscodium.com/) - Free/Libre Open Source Software Binaries of VS Code

## Adding Applications

Please submit a pull request, or create an issue with **a link to an actively maintained AppImage host**. Any requests without an active AppImage host will be declined, as I am not maintaining any of the AppImage binaries supplied above, only sourcing them.

If an application is already included by [EmuDeck](https://github.com/dragoonDorise/EmuDeck), I will not include it. This means no emulators will be added, please use that project instead.

## Installation

> Note: This application is designed for **Steam Deck** devices in mind *only*. While this likely will work with any *nix distribution, I cannot guarantee, nor will I support operating systems other than SteamOS. You have been warned.

Download the `.sh` file from the releases page on your Steam Deck. In the terminal, ensure that it is executable with a simple `chmod +x appimage-deck.sh`. Then run it either by double clicking it, or executing it from the terminal.

## Acknowledgements and Special Thanks

- [EmuDeck](https://github.com/dragoonDorise/EmuDeck) (Godsbane in particular) for the basis of the AppImage update script.
- Stack Overflow for reminding me how to be a functional developer.