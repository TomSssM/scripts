# File System and Checksums Sync

Check that the files on the file system match the Checksums Database:

__The Holidays__
```shell
DRIVE='/h' bash ./fs-n-checksums-sync.sh
```

__Buffer__
```shell
DRIVE='/h' bash ./fs-n-checksums-sync-2.sh
```

## Specification

### Environment Variables

| Name | Description |
|---|---|
| `DRIVE` | Path to the mounted Drive |
