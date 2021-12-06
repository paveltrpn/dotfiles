# note_book  
## Установка ядра 5.8 под Linux Mint 20  
  
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
  
## Cборка Mesa 3d 20.2

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
  
## Темы для VS Code
- Andromeda  
- New York  
- Noctis Obscuro  
- Nord  
- Soda Pop VS  
- Tokyo Night  
Новую тему из .json файла можно добавить так:  
1) Копируем .json файл в директорию какой нибудь темы, установленной через браузер расширений, в
   windows это папака - C:\Users\pavel_trpn\.vscode\extensions
2) в package.json этого расширения (цветовой темы) добавляем в секцию 
   ```"contributes": {
		"themes": [
			{
				"label": "Teme Name",
				"uiTheme": "vs-dark",
				"path": "./theme-file.json"
			},```  
  
Другие хорошие темы можно посмотреть - https://themes.vscode.one/theme/paveltrpn/BgDPpWrh  