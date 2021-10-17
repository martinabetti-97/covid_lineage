import pandas as pd
import numpy as np
import sys
import seaborn as sns
import matplotlib.pyplot as plt

file=sys.argv[1]

df=pd.read_csv(file,sep='\t')
df.index=df['sample']
df=df.drop('sample',axis=1)
df['median']=df.median(axis=1)
plt.figure(figsize=(30,20))
sns.heatmap(df1.sort_values(by='median',ascending=False),cmap=sns.color_palette('viridis', as_cmap=True), linewidths=.1)
plt.title('log10(coverage+1)',size=15)
plt.savefig('heatmap.png',bbox_inches="tight")
