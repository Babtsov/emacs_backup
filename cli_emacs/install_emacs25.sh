# install emacs 25 on centos 7
# src http://www.dpham.net/install-emacs-25-x-from-source-on-centos-7/

sudo yum install -y ncurses-devel gnutls-devel libxml2-devel automake autoconf
sudo yum install -y wget
sudo yum install texi2html texinfo
wget http://git.savannah.gnu.org/cgit/emacs.git/snapshot/emacs-25.2.tar.gz
tar xzvf emacs-25.2.tar.gz
cd emacs-25.2
sudo ./autogen.sh
sudo ./configure –without-makeinfo –with-x-toolkit=no –with-xpm=no –with-jpeg=no –with-png=no –with-gif=no –with-tiff=no
sudo make install
# install emacs 25 on utbuntu
# src http://sourcedigit.com/21272-ubuntu-install-latest-emacs-install-emacs-25-ubuntu-command-line/
