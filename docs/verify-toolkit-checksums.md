# Verify Toolkit Checksums

As Toolkit holds all the Checksums Databases you can easily verify its integrity given its structure:

```shell
DRIVE='/h' bash ./verify-toolkit-checksums.sh
```

Please note that this Script uses the Checksums Databases located inside __Toolkit__ on `DRIVE` (instead of the Checksums Databases located inside __Toolkit__ from which the Script is run) because __Toolkit__ is where we store Checksums Databases

---

## Specification

### Environment Variables

| Name | Description |
|---|---|
| `DRIVE` | Path to the mounted Drive |
