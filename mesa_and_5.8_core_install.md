# Установка ядра 5.8 под Linux Mint 20  
  
Ядро по умолчанию в Mint 20 - 5.4. Ядро 5.8 понадобилось, чтобы в VMWare Player 16 заработал OpenGL 4.1.   
Установка ядра 5.8 без сборки из *.deb пакетов очень проста. Скачиваем:  
  
- https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8/amd64/linux-headers-5.8.0-050800-generic_5.8.0-050800.202008022230_amd64.deb  
- https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8/amd64/linux-image-unsigned-5.8.0-050800-generic_5.8.0-050800.202008022230_amd64.deb
- https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.8/amd64/linux-modules-5.8.0-050800-generic_5.8.0-050800.202008022230_amd64.deb  
  
Далее просто запускаем:  
```
$ sudo dpkg -i *.deb  
```  
Нужно убедиться что в папке не т других *.deb пакетов. После перезагрузки ваполним:
``` 
uname -a  
```
  
# Cборка Mesa 3d 20.2

Скачиваем и паспаковываем дистрибутив с сайта Mesa 3d:

- https://docs.mesa3d.org/download.html  

Вообще, сборка описана там же на сайте. Собираем по инструкции https://docs.mesa3d.org/install.html. Если в кратце, то:  
```
meson builddir/
ninja -C builddir/
sudo ninja -C builddir/ install
```
  
Там будет много зависимостей от X11, устанавливаем все, конфигурирум и собираем через Meson и Ninja. После сборки Ninja закинет  
собраные бинарники в - `/usr/local/lib/x86_64-linux-gnu`, перемещаем всё это добро в `/usr/lib/x86_64-linux-gnu`.



