locals {
  node_pool_name = "${var.cluster_name}-np"
  master_ipv4_cidr = "172.16.0.0/28"
}
