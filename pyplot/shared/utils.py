import os

import matplotlib.pyplot as plt

COLORS = ['#008800', '#FF4D4D', '#5060D0', '#880000']
MARKERS = ['+', 'x', 'o', 'v']
HATCHES = ['x', '/', '+', '.']

plt.rcParams.update({
    "xtick.labelsize": "x-small",
    "ytick.labelsize": "x-small",
    "axes.titlesize": "x-small",
    "axes.labelsize": "x-small",
    "legend.fontsize": "x-small"})

def savefig():
    fig = plt.gcf()
    try:
        fig.tight_layout()
    except:
        pass
    if "OUT" in os.environ:
        fig.savefig(os.environ["OUT"], bbox_inches='tight')
    else:
        plt.show()
