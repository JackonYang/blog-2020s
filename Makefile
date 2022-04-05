g:
	hexo generate

s:
	hexo server

c:
	hexo clean

p:
	scp -r  public/* root@jackon.me:/mnt/data/site-jackon-me/

install:
	bash tools/install.sh
