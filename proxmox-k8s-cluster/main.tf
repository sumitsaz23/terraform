#create a new VM from a template with cloud-init enabled
resource "proxmox_vm_qemu" "k8s-nodes" {
  for_each    = var.vm_configs


  vmid        = each.value.vmid
  name        = each.value.name
  target_node = "pve01"
  agent       = 1
  cpu {
    cores = each.value.cpu_cores
    sockets = 1
    numa = true
    type = "x86-64-v2-AES"
  }
  memory      = each.value.memory
  bios        = "ovmf"
  boot        = "order=scsi0" # has to be the same as the OS disk of the template
  clone       = each.value.clone
  scsihw      = "virtio-scsi-single"
  vm_state    = each.value.vm_state # "running" or "stopped"
  automatic_reboot = true

  # Cloud-Init configuration
  cicustom   = "vendor=local:snippets/qemu-guest-agent.yml" # /var/lib/vz/snippets/qemu-guest-agent.yml
  ciupgrade  = true
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = each.value.ipconfig0
  skip_ipv6  = true
  ciuser     = "root"
  cipassword = "sur"
  

  # Most cloud-init images require a serial device for their display
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = "hdd-vm-data"
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size    = each.value.storage
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = "hdd-vm-data"
        }
      }
    }
  }

  network {
    id = 0
    bridge = "vmbr0"
    model  = "virtio"
  }
}