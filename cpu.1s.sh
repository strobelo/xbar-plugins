#!/bin/bash
loader="▁▂▃▄▅▆▇█"
charwidth=1

NORMAL=" </span> "

COLORS=("<span color='#46ac36'>" \
  "<span color='#80bf30'>"\
  "<span color='#abc729'>"\
  "<span color='#cec520'>"\
  "<span color='#e8b817'>"\
  "<span color='#fa9e11'>"\
  "<span color='#ff750f'>"\
  "<span color='#ff2711'>"\
)

echo -n "["
while IFS="," read -r col_time col_timeset col_cpun col_usr col_nice col_sys col_wait col_irq col_soft col_steal col_guest col_gnice col_idle
do
  i=$(printf "%.0f" "$col_usr")
  i=$(bc -l <<< "($i/100*7)")
  i=$(printf "%.0f" $i)
  COL=${COLORS[i]}
  echo -n $COL
  printf "%s" "${loader:$i:$charwidth}"
  echo -n $NORMAL
done < <(mpstat -P ALL 1 1 | sed -r 's/ +/,/g' | tail -n +5 | sed '/^Average/d' | head -n -1)
echo -n "]\n"
