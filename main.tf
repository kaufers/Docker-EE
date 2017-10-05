provider "ibm" {
    softlayer_username = "${var.softlayer_username}"
    softlayer_api_key  = "${var.softlayer_api_key}"
}

data "ibm_compute_ssh_key" "ssh_key" {
    label = "${var.ssh_label}"
}

resource "ibm_storage_file" "nfs_manager" {
    count      = 1  # Set to 0 to disable manager NFS
    capacity   = 20
    datacenter = "dal10"
    iops       = 10
    type       = "Endurance"
}

resource "ibm_compute_vm_instance" "manager" {
    hostname                 = "${var.name}"
    domain                   = "ibmcloud.com"
    os_reference_code       = "UBUNTU_LATEST"
    datacenter               = "dal10"
    cores                    = "1"
    memory                   = "2048"
    local_disk               = true
    hourly_billing           = true
    file_storage_ids         = ["${ibm_storage_file.nfs_manager.0.id}"]
    ssh_key_ids              = ["${data.ibm_compute_ssh_key.ssh_key.id}"]
}

variable softlayer_username {
    description = "Softlayer Username"
}

variable softlayer_api_key {
    description = "Softlayer API Key"
}

variable ssh_label {
    description = "Softlayer Public SSH key label"
}

variable datacenter {
    description = "Softlayer datacenter (i.e. dal10)"
    default = "dal10"
}

variable name {
    description = "Swarm name. Also used as a prefix for manager and worker hostnames."
    default = "d4ic"
}

variable manager_count {
    description = "Initial number of manager nodes"
    default = 3
}

variable worker_count {
    description = "Initial number of worker nodes"
    default = 3
}
