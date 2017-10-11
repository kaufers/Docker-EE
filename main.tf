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
    description = "To get your IBM Bluemix Infrastructure (Softlayer) user name, log in to SoftLayer, select your profile, and locate your API Username under the API Access Information section."
}

variable softlayer_api_key {
    description = "To get your IBM Bluemix Infrastructure (SoftLayer) API key, log in to SoftLayer, select your profile, and locate your Authentication Key under the API Access Information section."
}

variable ssh_label {
    description = "Your IBM Bluemix Infrastructure (SoftLayer) SSH key label for the manager node. To create a key, log in to SoftLayer and select Devices > Manager > SSH Keys > Add."
}

variable datacenter {
    description = "The location (data center) you deploy the Docker EE swarm to, such as dal10 or dal12."
    default = "dal10"
}

variable name {
    description = "Swarm name. Also used as a prefix for manager and worker hostnames."
    default = "d4ic"
}

variable manager_count {
    description = "Deploy 1, 3, or 5 manager nodes."
    default = 3
}

variable worker_count {
    description = "Deploy a minimum of 1 and maximum of 10 worker nodes."
    default = 3
}
