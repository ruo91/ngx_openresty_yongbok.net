.PHONY: all install clean

all:
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/LuaJIT-2.1-20140707 && $(MAKE) TARGET_STRIP=@: CCDEBUG=-g CC=cc PREFIX=/usr/local/openresty/luajit
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-cjson-2.1.0.1 && $(MAKE) DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/luajit-root/usr/local/openresty/luajit/include/luajit-2.1 LUA_CMODULE_DIR=/usr/local/openresty/lualib LUA_MODULE_DIR=/usr/local/openresty/lualib CJSON_CFLAGS="-g -fpic" CC=cc
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-redis-parser-0.10 && $(MAKE) DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/luajit-root/usr/local/openresty/luajit/include/luajit-2.1 LUA_LIB_DIR=/usr/local/openresty/lualib CC=cc
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-rds-parser-0.05 && $(MAKE) DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/luajit-root/usr/local/openresty/luajit/include/luajit-2.1 LUA_LIB_DIR=/usr/local/openresty/lualib CC=cc
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/nginx-1.7.2 && $(MAKE)

install: all
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/LuaJIT-2.1-20140707 && $(MAKE) install TARGET_STRIP=@: CCDEBUG=-g CC=cc PREFIX=/usr/local/openresty/luajit DESTDIR=$(DESTDIR)
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-cjson-2.1.0.1 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/luajit-root/usr/local/openresty/luajit/include/luajit-2.1 LUA_CMODULE_DIR=/usr/local/openresty/lualib LUA_MODULE_DIR=/usr/local/openresty/lualib CJSON_CFLAGS="-g -fpic" CC=cc
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-redis-parser-0.10 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/luajit-root/usr/local/openresty/luajit/include/luajit-2.1 LUA_LIB_DIR=/usr/local/openresty/lualib CC=cc
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-rds-parser-0.05 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_INCLUDE_DIR=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/luajit-root/usr/local/openresty/luajit/include/luajit-2.1 LUA_LIB_DIR=/usr/local/openresty/lualib CC=cc
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-dns-0.12 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-memcached-0.13 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-redis-0.20 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-mysql-0.14 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-string-0.09 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-upload-0.09 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-websocket-0.03 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-lock-0.03 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-lrucache-0.02 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-core-0.0.8 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/lua-resty-upstream-healthcheck-0.02 && $(MAKE) install DESTDIR=$(DESTDIR) LUA_LIB_DIR=/usr/local/openresty/lualib INSTALL=/usr/local/src/nginx/ngx_openresty-1.7.2.1/build/install
	cd /usr/local/src/nginx/ngx_openresty-1.7.2.1/build/nginx-1.7.2 && $(MAKE) install DESTDIR=$(DESTDIR)

clean:
	rm -rf build
