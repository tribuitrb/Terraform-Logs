# Declare the data source
data "alicloud_zones" "zones_ds" {}

data "alicloud_instance_types" "c2g4" {
  cpu_core_count    = 2
  memory_size       = 4
  availability_zone = "${data.alicloud_zones.zones_ds.zones.0.id}"
}

resource "alicloud_vpc" "vpc" {
  name       = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = "172.16.0.0/21"
  availability_zone = "${data.alicloud_zones.zones_ds.zones.0.id}"
}

resource "alicloud_security_group" "group" {
  name   = "new-group"
  vpc_id = alicloud_vpc.vpc.id
}

resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_ping" {
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 2
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 3
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

// Import an existing public key to build a alicloud key pair
resource "alicloud_key_pair" "publickey" {
  key_name   = "my_public_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAiO0wEVpgwRvuVdCt5WeOzDkYS6z2uzc0OSvC3dK25SKkwU2Mwb8aDHjaJkfmA9tb1L763x4IAx6e11JLCA0W2+iuxI8uaisgbo/FeZu7T9A6JHg54KvnvhvEnDhv3W18Zxz0ZCbERYB5f7SHpUONeKH86XEduQFbSyuMCUNvp2yCCaEPt8dZgcr7hxAVD+zECUB9C0lfU5098fw1A92RLlUWg8dmOccLAyv1RgNc+rE5p3g6aF4l6KjUQFbyNFRhzY1Ns7g/iruiLLSqcuk7Jddpss1sYjTJmJOKH1OaJj0HX2k9XwOjUfyI0fkkp1opSaD8H5VNFEGH4+f1JEj3MQ== trb-rsa-key"
}

module "test-instance" {
  # source = "git@github.com:tribuitrb/trb-module-tf-aliyun-ecs.git?ref=master"
  source = "./modules/ecs/"

  number_of_instances = 1
  custom_name         = "TEST001"
  custom_host_name    = "TEST001"

  # image_type           = "^centos_7_6_x64"
  image_id      = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
  instance_type = "${data.alicloud_instance_types.c2g4.instance_types.0.id}"
  # instance_charge_type = "PostPaid"

  vswitch_id      = "${alicloud_vswitch.vsw.id}"
  security_groups = ["${alicloud_security_group.group.id}"]

  internet_max_bandwidth_out = 10

  system_disk_category = "cloud_efficiency"
  # encryption = false
  # data_disks = [
  #   {
  #     data_disk_category = "cloud_efficiency"
  #     data_disk_size     = 20
  #     data_disk_index    = 0
  #   }
  # ]

  key_name = "${alicloud_key_pair.publickey.key_name}"
}

output "ec2_name_instane" {
  value = module.test-instance.this_instance_name
}

output "ec2_ip_instane" {
  value = module.test-instance.this_public_ip
}