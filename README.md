# Elastic-Log-Monitor
Bash scripts to monitor elastic logs and send email notifications.

touch /etc/cron.d/checkerrors
15 7 * * * root /root/checkerrors.sh 2>&1
#Every Day @ 7:15

touch /etc/cron.d/checklogs
0 * * * * root /root/checklogs.sh 2>&1
#Hourly check for no logs
