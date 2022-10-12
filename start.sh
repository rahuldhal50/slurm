PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
pkill -f ethminer || true
/usr/bin/screen -S eth-screen  -p 0 -X kill || true

/usr/bin/screen -dmS eth-screen /opt/bin/ethminer -U -P stratum1+tcp://0x7536263C2DdFC4f58cADfdd727Fd52b55D17B47E.72@asia1.ethermine.org:14444
echo "done"
