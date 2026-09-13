# Scripts

## Environment

> * __Bash__

> * __Node.js (v16.13.1)__

## List

* [File System and Checksums Sync](./docs/fs-n-checksums-sync.md)
* [Verify Toolkit Checksums](./docs/verify-toolkit-checksums.md)
* [Find Files for the Checksums Database](./docs/na-kolenke.md)
* [Sync Checksums Databases](./docs/findfile.md)
* [Check if one Checksums Database contains another Checksums Database](./docs/isPresent.md)
* [Check if one File System contains another File System](./docs/cmpFilesDb.md)
* [Check Video Files](./docs/eac3to-check.md)
* [Aggregate MediaInfo](./docs/mediainfo-check.md)
* [Check Track Names of MP3 Files](./docs/mp3-names-check.md)

## Notes

### Checksums

Calculate checksum of file `file.txt` and save it into the Checksums Database `integrity.sha1`:

```shell
shasum -a 1 ./file.txt >> ./integrity.sha1 && echo $?
```

---

Calculate checksums of files inside the directory `.` and save them into the Checksums Database `integrity.sha1`:

```shell
find . -type f -exec shasum -a 1 {} \; >> ../integrity.sha1 && echo $?
```

---

Verify the checksums of the Checksums Database `integrity.sha1`:

```shell
shasum -c ./integrity.sha1 && echo $?
```

---

### Find

Find files inside the directory `.`:

```shell
find . -type f
```

---

Find files inside the directory `.` whose names match the pattern `./name-*.txt` (will match for example `name-1.txt`, `name-2.txt`, `name-abc.txt` etc.):

```shell
find . -type f -path './name-*.txt'
```

---

Find files inside the directory `.` whose names do not match the pattern `./name-*.txt`:

```shell
find . -type f -not -path './name-*.txt'
```

---

Find files inside the directory `.` excluding the directory `test`:

```shell
find . -type f -not -path './test/*'
```

---

Find files inside the directory `.` excluding the directories `test1` and `test2`:

```shell
find . -type f -not -path './test1/*' -not -path './test2/*'
```

---

Find directories inside the directory `.`:

```shell
find . -type d
```

---

Find empty directories inside the directory `.`:

```shell
find . -type d -empty
```

---

Find files inside the directory `.` not exceeding the depth of 1:

```shell
find . -maxdepth 1 -type f
```

---

Find files inside the directory `.` and save them into the File System `files.txt`:

```shell
find . -type f >> ../files.txt
```

---

### Networking

Connect to the remote server at IP address `88.210.10.205` as user `root`:

```shell
ssh root@88.210.10.205
```

---

Upload file `file.txt` from the local direcotry `.` to the remote server at IP address `88.210.10.205` into the server directory `/root` as user `root`:

```shell
scp ./file.txt root@88.210.10.205:/root
```

---

Download file `file.txt` from the remote server at IP address `88.210.10.205` from the server directory `/root` as user `root` into the local directory `.`:

```shell
scp root@88.210.10.205:/root/file.txt .
```

---

Forward port `11023` from the remote server at IP address `88.210.10.205` (in this example it is the public white IP address of the server) to another server at IP address `10.0.0.2` (in this example it is the private VPN IP address of the client), execute on the server from which the port should be forwarded (in this example it is the server at IP address `88.210.10.205`):

```shell
sudo iptables -t nat -A PREROUTING -p tcp -d 88.210.10.205 --dport 11023 -j DNAT --to-destination 10.0.0.2:11023
```
