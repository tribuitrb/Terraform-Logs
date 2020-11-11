# Declare the data source
data "alicloud_zones" "zones_ds" {}

data "alicloud_instance_types" "c2g4" {
  cpu_core_count = 2
  memory_size    = 4
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

# resource "alicloud_security_group_rule" "allow_all_tcp" {
#   type              = "ingress"
#   ip_protocol       = "tcp"
#   nic_type          = "internet"
#   policy            = "accept"
#   port_range        = "1/65535"
#   priority          = 1
#   security_group_id = alicloud_security_group.default.id
#   cidr_ip           = "0.0.0.0/0"
# }

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

# Create a web server
resource "alicloud_instance" "web" {
  image_id                   = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
  internet_charge_type  = "PayByBandwidth"

  instance_type        = "${data.alicloud_instance_types.c2g4.instance_types.0.id}"
  system_disk_category = "cloud_efficiency"
  security_groups      = ["${alicloud_security_group.group.id}"]
  instance_name        = "web"
  vswitch_id                 = alicloud_vswitch.vsw.id
  key_name = alicloud_key_pair.publickey.key_name
  internet_max_bandwidth_out = 10
}

# resource "alicloud_instance" "instance" {
#   # cn-beijing
#   availability_zone = "cn-beijing-b"
#   security_groups   = alicloud_security_group.group.*.id

#   # series III
#   instance_type              = "ecs.n4.large"
#   system_disk_category       = "cloud_efficiency"
#   system_disk_name           = "test_foo_system_disk_name"
#   system_disk_description    = "test_foo_system_disk_description"
#   image_id                   = "ubuntu_18_04_64_20G_alibase_20190624.vhd"
#   instance_name              = "test_ubuntu"
#   vswitch_id                 = alicloud_vswitch.vswitch.id
#   internet_max_bandwidth_out = 10
#   data_disks {
#     name        = "disk2"
#     size        = 20
#     category    = "cloud_efficiency"
#     description = "disk2"
#     encrypted   = true
#     # kms_key_id  = alicloud_kms_key.key.id
#   }
# }
