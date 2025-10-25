
sudo iptables-save > iptab
vim iptab
sudo iptables-restore < iptab
