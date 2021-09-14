# Hoddarla 專案：鐵人賽第六天

## 實驗步驟

今天這個版本，可以在 OpenSBI 之後跑出 `HI` 字樣，以及隨後而來的三組狀態暫存器的顯示。

之後可以使用 `Ctrl+A` `X` 中止 QEMU。

### 從舊的 repo 繼續實驗

```
# in Hoddarla directory
git pull origin ithome
make apply         # 引用新增的 patch
make stamps/go-env # 由於牽扯到組譯器，需要重編工具鏈
. .hdlarc
make clean && make
```

### 從頭開始

```
git clone git@github.com:NonerKao/Hoddarla.git
cd Hoddarla
make env
. .hdlarc
make clean && make
```


