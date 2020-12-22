# Hodgepodge machine

Cellular automata which leads to distinct spatially organized patterns like those seen in the Belousov-Zhabotinsky reaction and other catalytic reactions. 

The command is run by:
```
hodgepodge(siz, n, k_1, k_2, g, t_steps)
```
where:
`siz` = 2-tuple with dimensions of automaton grid
`n` = number of states for each cell
`k_1` = constant which scales number of local infected states 
`k_2` = constant which scales number of local ill states
`g` = infection rate
`t_steps` = number of time steps to run for

Most classic settings which produce reaction-diffusion spiral structures corresponds to:
```
hodgepodge([200 100], 100, 3, 2, 20, 4000)
```

Original model outlined in Gerhardt and Schuster (1988). 
