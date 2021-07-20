"""minion entrypoint"""
import sys
import subprocess


def run():

    cmd = ['salt-minion']
    if len(sys.argv) > 1:
        cmd += sys.argv[1:]
    subprocess.run(cmd)


if __name__ == '__main__':
    run()
