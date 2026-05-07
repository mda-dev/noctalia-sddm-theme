# Noctalia SDDM Theme (unofficial)

This repo represents my current attempts to mimic the Noctalia lock screen as a
theme for SDDM with the kanagawa color sheme as default

Inspiration: [Noctalia SDDM Theme](https://github.com/mahaveergurjar/sddm/tree/noctalia)
and [Noctalia Dev](https://noctalia.dev/)
![Preview Image](Assets/preview.webp "Preview")

## Features

- Multiple user support (clicking top card allows you to switch between users)
- Standalone SDDM theme using `theme.conf`
- Color sync with Noctalia-Shell via user-templates (optional)
- Script for installation / removal `./installer/install.sh`
  - theme directory: `/usr/share/sddm/themes/noctalia`
  - SDDM configuration: `/etc/sddm.conf.d/noctalia.conf`
  - shell integration: `~/.config/noctalia/user-templates.toml` (optional)
- Wallpaper sync with Noctalia-Shell via script `sync-shell-wallpaper.sh` (optional) (Tested Noctalia Shell <= v4.7.5 )
- Various customizable settings via `theme.conf` or
  `theme.template.conf` see [Configuration](#configuration) section

> [!NOTE]
> Theme Dependencies
> Fedora: `sddm`, `sddm-wayland-generic`, `qt6-qt5compat`, `qt6-qtsvg`
> Arch/CachyOS: `sddm`, `qt6-5compat`, `qt6-svg`
> Misc Dependencies (installer)
> `jq` - used for handling .json mutations (wallpaper-sync)
> `awk` - use for handling .conf mutations (installer)

> [!NOTE]
> The theme targets Qt6 SDDM greeters. The installer test command prefers
> `sddm-greeter-qt6` and falls back to `sddm-greeter` when the Qt6 binary is
> not available separately.

## Installation

Clone repo with `git clone https://github.com/mda-dev/noctalia-sddm-theme.git noctalia`

For quick information about what the installer will do,
you can run it with `--dry-run` argument and no changes will be made.

<details>
  <summary> Automatic (with scripts) </summary>
  Run the installer script from within the installer directory.

```sh
sudo bash ./installer/install.sh
```

You will be prompted during the installation for the following optional features:

- Noctalia-Shell color sync.
- Noctalia-Shell wallpaper sync. (Tested Noctalia-Shell <= v4.7.5)

If you install / configure the sync "features" you will need to change
the color scheme and wallpaper once for changes to take effect.

The optional Noctalia sync steps assume a mutable system install under
`/usr/share/sddm/themes/noctalia`. Image-based or read-only distro packages
should install the theme normally and choose their own writable output paths for
generated config or synced assets.

After installation you can use the [Test command](#test-theme-installation)
to view results

</details>

<details>
  <summary>
    Manual (scriptless)
  </summary>

### Theme

Copy directory to sddm themes with `sudo cp -r noctalia /usr/share/sddm/themes`

Activate theme by creating or editing `/etc/sddm.conf.d/noctalia.conf` with:

```ini
[Theme]
Current=noctalia
```

### Noctalia-Shell (optional)

The theme works without Noctalia. In that mode, edit the installed
`theme.conf` directly and leave `theme.template.conf` unused.

Noctalia users can enable user templates and render `theme.template.conf` to the
installed theme's `theme.conf`. The SDDM greeter only reads the installed theme
config; it does not read `~/.config/noctalia` directly.

### Color-Sync

Enable User Templates in Noctalia-Shell `Settings > Color Schemes > Templates`

Edit `~/.config/noctalia/user-templates.toml` Add the following lines to the bottom:

```ini
# SDDM GREETER
[templates.sddm]
input_path = "/usr/share/sddm/themes/noctalia/theme.template.conf"
output_path = "/usr/share/sddm/themes/noctalia/theme.conf"
```

On mutable installs, the installer makes the installed `theme.conf` writable by
the installing user for this output path. If your distro packages the theme in a
read-only location, keep `theme.template.conf` as the source and point Noctalia
at a packaging-specific writable output path instead.

### Wallpaper-sync

Open Noctalia-Shell `Settings > Hooks` and add the following inside
"Wallpaper changed" then press the Test button

```sh
/usr/share/sddm/themes/noctalia/sync-shell-wallpaper.sh
```

Wallpaper sync copies the selected wallpaper over the installed
`Assets/background.png`. It only works when that installed asset path is
writable by the hook. On immutable or image-based distros, package the theme and
adjust the hook or packaging to use a distro-owned writable target path.

</details>

## Test theme installation

```sh
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/noctalia
```

If your distro still exposes the greeter as `sddm-greeter`, use:

```sh
sddm-greeter --test-mode --theme /usr/share/sddm/themes/noctalia
```

## Configuration

#### Avatar

The theme searches for the following files in the exact order they are listed below.
Once a file has been found the search stops.

```
$HOME/.face.icon
$HOME/.face
/usr/share/sddm/faces/$USER.face.icon
/var/lib/AccountsService/icons/$USER
/usr/share/sddm/themes/noctalia/Assets/logo.svg
```

#### General UI

The place where you can configure some settings changes
depending if you enable Color-Sync

<details>
<summary>With Color-Sync</summary>

Open `theme.template.conf` with your favorite editor and change any of the values
you see fit and then refresh your theme within Noctalia settings

> [!WARNING]
> Do not change values start with the letter `m` ex `mPrimary`, those are set by Noctalia-Shell
> whenever you change your theme.
> The Color-Sync won't work anymore

</details>

<details>
<summary>Without Color-Sync (standalone)</summary>

Open `theme.conf` file with your favorite editor and  
 change any of the values you see fit.

```sh
sudo nano /etc/share/sddm/themes/noctalia/theme.conf
```

</details>
