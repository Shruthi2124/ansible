**Manual steps: **
-----------------
-sudo apt update
-sudo apt install openjdk-8-jdk tomcat9 -y
-cd /tmp
-wget https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/gameoflife.war
-sudo cp gameoflife.war /var/lib/tomcat9/webapps/gameoflife.war
![preview](../images/an32.png)
---
playbook of gol without variables:
```
- name: installing gol
  hosts: all
  become: yes
  tasks: 
    - name: updating packages installing java
      ansible.builtin.apt:
        name: openjdk-8-jdk
        state: present
    - name: updating packages installing tomcat9
      ansible.builtin.apt:
        name: tomcat9
        state: present
    - name: creating directory if doesnot exists
      ansible.builtin.file:
        path: ~/tmp/
        state: directory
        mode: '0777'
        recurse: yes
    - name: downloading gol
      ansible.builtin.get_url: 
        url: https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/gameoflife.war
        dest: /tmp/gameoflife.war 
    - name: copying warfile
      ansible.builtin.copy:
        src: /tmp/gameoflife.war 
        dest: /var/lib/tomcat9/webapps/gameoflife.war
        remote_src: yes
  ```
  ![preview](../images/an33.png)

