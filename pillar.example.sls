sysctl:
  params:
    - name: vm.swappiness
      value: 20
    - name: /sys/kernel/mm/ksm/run
      value: 1
      set: manual
    - name: /sys/kernel/mm/ksm/sleep_millisecs
      value: 200
      set: manual
