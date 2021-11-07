#!/bin/sh
#Simple bash script of Riecoin installation on HiveOS

#Riecoin miner installation path
install_path="/home/user/RIC/"

#Creates a directory structure and downloads Riecoin miner
mkdir -p $install_path
cd $install_path
wget https://riecoin.dev/resources/Pttn/rieMiner0.93AVX2Ubu18
chmod +x rieMiner0.93AVX2Ubu18

#Make a bash script to run miner
echo '
#!/bin/sh

miner_path="/home/user/RIC"
miner_name="rieMiner0.92dUbu18Avx2"
cofing_file="suprnova.cc.config"
marker=`ps -e | grep rieMiner`

if [ -z "$marker" ];
  then
    screen -Smd RIC $miner_path/$miner_name $miner_path/$cofing_file;
  else
    killall $miner_name && screen -Smd RIC $miner_path/$miner_name $cofing_file;
fi
' > start.sh

#Add permissions to run script
chmod +x start.sh

#Make a config file for miner
echo '
Mode = Pool
Host = ric.suprnova.cc
Port = 5000
Username = MinerNinja.TRX
Password = x
#Threads = 16
' > suprnova.cc.config

#Add miner to system startup
echo '@reboot /home/user/RIC/start.sh' >> /hive/etc/crontab.root

#Miner auto restart every 30 min
echo '*/30 * * * * /home/user/RIC/start.sh' >> /hive/etc/crontab.root
