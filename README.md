# Bash Backup Automation Script

## Project Overview

An end-to-end Bash script designed to automate daily backups of files modified within the last 24 hours.

## Key Highlights

- Incremental backups of only the files changed in the past day to minimize storage and I/O use
- Robust error handling enabled by `set -euo pipefail` and thorough input validation
- Accurate path resolution of relative paths and symbolic links using `realpath -m`
- Ready to schedule via cron for midnight execution
- Self-documenting help flag (`--help`) and clear inline comments for maintainability

## Skills and Technologies

- Shell scripting with Bash functions, arrays, arithmetic, conditional expressions, and here-docs
- Unix tools including `tar` for archiving, `date` for timestamps, `realpath` for path normalization, and cron scheduling
- Version control best practices with Git initialization, branching, remote setup, `.gitignore`, and semantic commit messages
- Automation using GitHub CLI for repository creation and cron job management
- Best practices for script modularity, informative user messages, and logging readiness

## Repository Structure

- **backup.sh**: the main backup script
- **cron/** directory: contains example cron configuration for daily execution at midnight
- **LICENSE**: the MIT License file
- **README.md**: project overview and usage instructions
- **.gitignore**: patterns for files and directories to exclude from Git tracking

## Installation and Usage

1. Clone the repository using your Git credentials, for example:
   ```bash
   git clone https://github.com/jans108/bash-backup-script.git
   cd bash-backup-script
   ```
2. Make the script executable by running:
   ```bash
   chmod +x backup.sh
   ```
3. Execute the backup script by specifying a source directory and a destination directory, for example:
   ```bash
   ./backup.sh ~/projects ~/backups
   ```
4. To automate daily backups at midnight, edit your crontab (`crontab -e`) and add a line such as:
   ```cron
   0 0 * * * /usr/local/bin/backup.sh /home/user/projects /home/user/backups
   ```

## Professional Summary

I developed a fully automated backup solution in Bash that performs incremental archiving of recently modified files using `tar` and timestamp logic. It implements strict error handling with `set -euo pipefail`, canonical path normalization with `realpath -m`, and seamless cron scheduling. The repository follows Git best practices including semantic commits, `.gitignore` configuration, and CI-ready structure.

## Contributing

Contributions, issues, and feature requests are welcome. Feel free to fork the project, make improvements such as S3 upload integration or enhanced logging, and submit a pull request for review.


