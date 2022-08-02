# folderSync

Automatically sync the contents of two directories

## Usage

```shell
bash folderSync.sh mode path/to/source/dir path/to/destiantion/dir
```

where `mode` can be `copy` or `move`

## Atuomation

Use the provided systemd unit and timer, or create a cron job

The provided timer will sync all directory pairs as configued in $XDG_CONFIG_HOME/folderSync.conf evey day at 03:15

### Using the provided Unit files

copy or link this directory to `/opt/folderSync/`

link `/opt/folderSync/autoSync.service` to `/etc/systemd/user/autoSync.service`:

```shell
sudo ln -s /opt/folderSync/autoSync.service /etc/systemd/user/
```

link `/opt/folderSync/autoSync.timer` to `/etc/systemd/user/autoSync.timer`:

```shell
sudo ln -s /opt/folderSync/autoSync.timer /etc/systemd/user/
```

Enable the timer:
```shell
systemctl --user enable autoSync.timer
```

## Configuration

similarly to the arguments of folderSync.sh, one directory pair per line:

example $XDG_CONFIG_HOME/folderSync.conf:

```
copy /absolute/path/to/source /absolute/path/to/destiantion
move /absolute/path/to/source2 /absolute/path/to/destiantion2
copy /absolute/path/to/source3 /absolute/path/to/destiantion3
copy /absolute/path/to/source4 /absolute/path/to/destiantion4
move /absolute/path/to/source5 /absolute/path/to/destiantion5
```
