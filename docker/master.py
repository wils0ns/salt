"""master entrypoint"""
import sys
import subprocess


def run():

    subprocess.run(['salt-syndic', '-d'])
    subprocess.run(['salt-api', '-d'])

    cmd = ['salt-master']
    if len(sys.argv) > 1:
        cmd += sys.argv[1:]
    subprocess.run(cmd)


if __name__ == '__main__':
    run()
