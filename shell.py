import subprocess
import os
import logging
import time

# Set up logging
logging.basicConfig(filename='activity.log', level=logging.INFO, format='%(asctime)s - %(message)s')

# Function to monitor shell commands
def monitor_shell_commands():
    while True:
        # Get the most recent shell command executed
        try:
            command = subprocess.check_output(['history', '-n', '1']).decode().strip()
            logging.info(f'Shell Command: {command}')
        except Exception as e:
            logging.error(f'Error monitoring shell commands: {e}')
        
        # Sleep for a short interval
        time.sleep(1)

# Function to monitor Git repository activities
def monitor_git_repos():
    while True:
        # Specify the paths to the Git repositories to monitor
        git_repos = ['/path/to/repo1', '/path/to/repo2']  # Add more repositories as needed
        
        for repo in git_repos:
            try:
                # Check the git log to get recent activity
                recent_activity = subprocess.check_output(['git', 'log', '--oneline', '-n', '1'], cwd=repo).decode().strip()
                logging.info(f'Git Activity in {repo}: {recent_activity}')
            except Exception as e:
                logging.error(f'Error monitoring Git repo {repo}: {e}')
        
        # Sleep for a short interval
        time.sleep(10)

# Main function to start monitoring
def main():
    try:
        # Start monitoring shell commands in a separate thread
        shell_monitor_thread = threading.Thread(target=monitor_shell_commands)
        shell_monitor_thread.start()
        
        # Start monitoring Git repository activities in a separate thread
        git_monitor_thread = threading.Thread(target=monitor_git_repos)
        git_monitor_thread.start()
        
        # Keep the main thread alive
        shell_monitor_thread.join()
        git_monitor_thread.join()
    except KeyboardInterrupt:
        logging.info('Monitoring stopped by user')

if __name__ == "__main__":
    main()
