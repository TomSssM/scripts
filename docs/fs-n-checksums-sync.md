# File System and Checksums Sync

Check that the files on the File System match the Checksums Database:

---

### The Holidays

```shell
DRIVE='/h' bash ./fs-n-checksums-sync.sh
```

#### Выходные

```shell
DRIVE='/h' bash ./fs-n-checksums-sync-legacy-stuff.sh
```

---

#### The Holidays Base

```shell
DRIVE='/h' bash ./fs-n-checksums-sync-base.sh
```

---

#### The Holidays DVD

```shell
DRIVE='/h' bash ./fs-n-checksums-sync-dvd.sh
```

---

#### The Holidays HD

```shell
DRIVE='/h' bash ./fs-n-checksums-sync-hd.sh
```

---

### Buffer

```shell
DRIVE='/h' bash ./fs-n-checksums-sync-2.sh
```

#### Buffer (The Holidays Base)

```shell
DRIVE='/h' bash ./fs-n-checksums-sync-base-2.sh
```

#### Buffer (The Holidays DVD)

```shell
DRIVE='/h' bash ./fs-n-checksums-sync-dvd-2.sh
```

#### Buffer (The Holidays HD)

```shell
DRIVE='/h' bash ./fs-n-checksums-sync-hd-2.sh
```

---

### Toolkit

```shell
DRIVE='/h' bash ./fs-n-checksums-sync-3.sh
```

Please note that the Script for __Toolkit__ uses the Checksums Databases located inside __Toolkit__ on `DRIVE` (instead of the Checksums Databases located inside __Toolkit__ from which the Script is run) because __Toolkit__ is where we store Checksums Databases

---

## Specification

### Environment Variables

| Name | Description |
|---|---|
| `DRIVE` | Path to the mounted Drive |
