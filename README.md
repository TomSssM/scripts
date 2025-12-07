# Scripts

## Environment

> * __Bash__

> * __Node.js (v16.13.1)__

## List

* [File System and Checksums Sync](./docs/fs-n-checksums-sync.md)
* [Find Files for the Checksums Database](./docs/na-kolenke.md)
* [Sync Checksums Databases](./docs/findfile.md)
* [Check if one Checksums Database contains another Checksums Database](./docs/isPresent.md)
* [Check if one File System contains another File System](./docs/cmpFilesDb.md)
* [Check Video Files](./docs/eac3to-check.md)
* [Aggregate MediaInfo](./docs/mediainfo-check.md)
* [Check Track Names of MP3 Files](./docs/mp3-names-check.md)

## Notes

### Checksums

Calculate checksum of file `file.txt` and save it into Checksums Database `integrity.sha1`:

```shell
shasum -a 1 ./file.txt >> ./integrity.sha1 && echo $?
```

---

Calculate checksums of files inside the directory `.` and save them into Checksums Database `integrity.sha1`:

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

Find files inside the directory `.` excluding the directory `test`:

```shell
find . -type f -not -path "./test/*"
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

Find files inside the directory `.` and save them into File System `files.txt`:

```shell
find . -type f >> ../files.txt
```

---

### Networking

Connect to remote server at IP address `88.210.10.205` as user `root`:

```shell
ssh root@88.210.10.205
```

---

Upload file `file.txt` from the local direcotry `.` to remote server at IP address `88.210.10.205` into the server directory `/root` as user `root`:

```shell
scp ./file.txt root@88.210.10.205:/root
```

---

Download file `file.txt` from remote server at IP address `88.210.10.205` from the server directory `/root` as user `root` into the local directory `.`:

```shell
scp root@88.210.10.205:/root/file.txt .
```

---

Forward port `11023` from remote server at IP address `10.0.0.1` (in the example it is server private VPN IP address) to another server at IP address `10.0.0.2` (in the example it is client private VPN IP address), execute on the server from which the port should be forwarded (in the example it is server at IP address `10.0.0.1`):

```shell
sudo iptables -t nat -A PREROUTING -p tcp -d 10.0.0.1 --dport 11023 -j DNAT --to-destination 10.0.0.2:11023
```

---
