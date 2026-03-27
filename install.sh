#!/usr/bin/env bash
set -euo pipefail

# word-smithy installer
# Usage: ./install.sh [claude|codex|cursor|all]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_FILE="$SCRIPT_DIR/SKILL.md"

install_claude() {
    local target_dir="$HOME/.claude/skills/word-smithy"
    mkdir -p "$target_dir"

    if [ -L "$target_dir/SKILL.md" ] || [ -f "$target_dir/SKILL.md" ]; then
        echo "word-smithy already installed for Claude Code at $target_dir"
        echo "Overwrite? (y/N)"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            echo "Skipped Claude Code installation."
            return
        fi
        rm -f "$target_dir/SKILL.md"
    fi

    ln -s "$SKILL_FILE" "$target_dir/SKILL.md"
    echo "Installed for Claude Code: $target_dir/SKILL.md -> $SKILL_FILE"

    # Create shared config directory if it doesn't exist
    local config_dir="$HOME/.claude/shared/word-smithy"
    if [ ! -d "$config_dir" ]; then
        mkdir -p "$config_dir"
        cp "$SCRIPT_DIR/config/shared-config-example.md" "$config_dir/config.md"
        echo "Created config template at $config_dir/config.md (edit this with your paths)"
    fi
}

install_codex() {
    local target_dir=".agents/skills/word-smithy"
    mkdir -p "$target_dir"
    cp "$SKILL_FILE" "$target_dir/SKILL.md"
    echo "Installed for Codex: $target_dir/SKILL.md"
}

install_cursor() {
    echo ""
    echo "For Cursor, add this to your .cursorrules file:"
    echo ""
    echo "  When writing any prose, follow the instructions in word-smithy/SKILL.md"
    echo ""
    echo "Or copy the SKILL.md content directly into your Cursor custom instructions."
    echo ""
}

print_next_steps() {
    echo ""
    echo "Next steps:"
    echo "  1. Create a voice profile:    see guides/creating-a-voice-profile.md"
    echo "  2. Condense a writing book:   see guides/condensing-a-book.md"
    echo "  3. Write a protocol:          see guides/writing-a-protocol.md"
    echo "  4. Edit your config:          ~/.claude/shared/word-smithy/config.md"
    echo ""
    echo "Then invoke /word-smithy in your AI assistant and start writing."
}

case "${1:-all}" in
    claude)
        install_claude
        print_next_steps
        ;;
    codex)
        install_codex
        print_next_steps
        ;;
    cursor)
        install_cursor
        print_next_steps
        ;;
    all)
        install_claude
        install_codex
        install_cursor
        print_next_steps
        ;;
    *)
        echo "Usage: ./install.sh [claude|codex|cursor|all]"
        exit 1
        ;;
esac
