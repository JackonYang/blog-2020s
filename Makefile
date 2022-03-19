g:
	hexo generate

s:
	hexo server

c:
	hexo clean

pub:
	scp -r  public/* root@jackon.me:/mnt/data/site-jackon-me/

install:
	bash tools/install.sh
