#!/usr/bin/env python
import nested_dict as nd

d = nd.nested_dict()
d["a"]["b"]["c"] = 3
print(d)

ls = [['a','a1','a2','a3'],['b','b1','b2','b3'],
      ['c','c1','c2','c3'], 
['d','d1','d2','d3']]

# this means to create four empty dict inside data_dict

data_dict = {f'dict{i}':{} for i in range(4)}
for i in range(4):
    upd_dict = {'val' : ls[i][0], 'val1' : ls[i][1],'val2' : ls[i][2],'val3' : ls[i][3]}
    data_dict[f'dict{i}'].update(upd_dict)

print(data_dict)    
print(f"data_dict['dict2']['val2']={data_dict['dict2']['val2']}")
    

################################################################################
#vim: syntax=python cc=80 tw=79 ts=4 sw=4 sts=4 et sr
################################################################################

