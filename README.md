# perfSONAR QA testbed
This reposiory and this README file contain instructions and playbook to maintain perfSONAR hosts to participate to the perfSONAR Quality Assurance testbed. We will assume Ansible knowledge and previous experience with [perfSONAR](https://www.perfsonar.net), our [generic Ansible playbook](https://github.com/perfsonar/ansible-playbook-perfsonar/) and roles.

## Contributions
If you want to use this setup and be part of our QA testbed, please [contact us](https://github.com/perfsonar/project/issues/new) explaining us how you want to help and what are the resources you can dedicate. Thank you.

## Preparing your setup
Once you have dedicated resources to commit to the perfSONAR QA testbed, use the following instructions.

### Prepare your Ansible controller
The playbook relies on some roles being present on your Ansible controller.  You can install them with a regular:
```
ansible-galaxy install -r  requirements.yml
```

### Create and provision your hosts
You'll need to have machines ready with a basic OS install and an adminitration user (i.e. either root or a regular user with sudo/su access). Machines need to be reachable from your Ansible controller (the host where you'll be running the playbook contained in this repository). For ease of management, the default setup will create a `psadmin` user on each machine and add ssh keys to grant access to your team.

### Add your hosts to inventory
Add your hosts in the Ansible inventory (`inventory/hosts` by default) and create a group for your organisation (ex: qalab). It's probably best to define a short name for your host in your group with the FQDN or IP as `ansible_host`.  Then add your hosts (short names) in the perfSONAR category you will assign them, this is usually either `ps_testpoint` or `ps_toolkit` and choose one of the `perfsonar_release` you want to assign them to (take a look inside `inventory/group_vars/ps_installer.yml` to know the different options, it depends on the distro your host is running).

### Configure variables
Look into the various variables files in the inventory file and directory and adapt to your deployment.  Of particular interest are:
* in `inventory/hosts`:
  * `ansible_user` and `ansible_become_user`: depending on your setup
* in `inventory/group_vars/all.yml`:
  * `psadmin_user_keys`: public ssh keys of individuals accessing the testbed hosts
  * to keep secret: `psadmin_password` but the `psadmin` is also granted sudo access without password.
* from `inventory/group_vars/ps_archive.yml`:
  * `perfsonar_archive_auth_list` add the IPs of your hosts to the list and push it to the git repository.
* in `inventory/group_vars/ps_testpoint.yml`:
  * `perfsonar_ntp_servers` a good set of NTP servers for your hosts
* in `inventory/group_vars/ps_toolkit.yml`:
  * to keep secret: `perfsonar_web_passwd`


### Prometheus monitoring
To be added.

## First run of the playbook
After configuring the different variables, you can run the full playbook with something like one of the folowings (depending on your setup accessing your new hosts):
```
ansible-playbook site.yml -l qalab
ansible-playbook -u your_user -K site.yml -l qalab
ansible-playbook -u your_user -K -e bootstrap_user=your_user site.yml -l qalab
```

If you don't want to run the bootstrapping or provisioning part, exclude the corresponding tag from your run with something like:
```
ansible-playbook --skip-tags bootstrap site.yml -l qalab
```

## Maintenance of your setup
Once the initial run has been done, you shouldn't need to run the playbook again. But it is indempotent and you can run it again without worry.

## Notes
In case you need a reference, the perfSONAR hosts management part of the setup described here is coming from our [regular perfSONAR Ansible playbook](https://github.com/perfsonar/ansible-playbook-perfsonar).

Set up individual host variables with the lsregistration.yml template

```
mkdir inventory/host_vars/myhostname
cp roles/ansible-role-perfsonar-testpoint/defaults/lsregistration.yml \
  inventory/host_vars/myhostname
vi inventory/host_vars/myhostname/lsregistration.yml
```

Run the playbook:

```
ansible-playbook perfsonar.yml
```

---

**Some useful commands to manage the environment**

Use Ansible ping to verify connectivity to targets:

```
ansible all -m ping
```

