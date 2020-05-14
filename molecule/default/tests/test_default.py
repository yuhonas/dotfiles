import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')

def test_zsh_is_the_default_shell(host):
    ansible_user = host.ansible.get_variables()['ansible_user']

    assert host.user(ansible_user).shell.endswith('zsh')

def test_zsh_modules_loaded(host):
    cmd_output = host.check_output('zsh -ci "antibody list"')

    assert len(cmd_output.split('\n')) == 8
