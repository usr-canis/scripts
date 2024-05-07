#!/bin/bash

# Backup directory
backup_dir="$HOME/.gnome_settings_backup"

# Function to backup currently set theme, icon pack, and GNOME extensions
backup_settings() {
    # Create backup directory if it doesn't exist
    mkdir -p "$backup_dir"

    # Backup GNOME Shell theme
    gsettings get org.gnome.shell.extensions.user-theme name > "$backup_dir/theme.txt"

    # Backup GNOME Shell icon pack
    gsettings get org.gnome.desktop.interface icon-theme > "$backup_dir/icon_pack.txt"

    # Backup enabled GNOME Shell extensions
    gnome-extensions list > "$backup_dir/extensions.txt"

    # Backup GNOME Shell theme files
    cp -r "$HOME/.themes" "$backup_dir/"

    echo "Backup completed successfully."
}

# Function to restore previously backed up settings
restore_settings() {
    # Check if backup files exist
    if [ -f "$backup_dir/theme.txt" ] && [ -f "$backup_dir/icon_pack.txt" ] && [ -f "$backup_dir/extensions.txt" ]; then
        # Restore GNOME Shell theme
        gsettings set org.gnome.shell.extensions.user-theme name "$(cat $backup_dir/theme.txt)"

        # Restore GNOME Shell icon pack
        gsettings set org.gnome.desktop.interface icon-theme "$(cat $backup_dir/icon_pack.txt)"

        # Restore enabled GNOME Shell extensions
        while IFS= read -r extension; do
            gnome-extensions enable "$extension"
        done < "$backup_dir/extensions.txt"

        # Restore GNOME Shell theme files
        cp -r "$backup_dir/.themes" "$HOME/"

        echo "Restore completed successfully."
    else
        echo "Backup files not found. Nothing to restore."
    fi
}

# Main function
main() {
    if [ "$1" = "backup" ]; then
        backup_settings
    elif [ "$1" = "restore" ]; then
        restore_settings
    else
        echo "Usage: $0 [backup | restore]"
        exit 1
    fi
}

# Run the script with the provided arguments
main "$@"
