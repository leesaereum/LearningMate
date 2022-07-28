# import
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import warnings
warnings.filterwarnings("ignore")

def boxplot_by_columns(data):

  fig = plt.figure(figsize=(17,14))
  ax1 = fig.add_subplot(2,3,1)
  ax2 = fig.add_subplot(2,3,2)
  ax3 = fig.add_subplot(2,3,3)
  ax4 = fig.add_subplot(2,3,4)
  ax5 = fig.add_subplot(2,3,5)
  ax6 = fig.add_subplot(2,3,6)

  ax1.boxplot(
      data['depth'],
      labels = ['depth']
  )

  ax2.boxplot(
      data['table'],
      labels = ['table']
  )
  ax3.boxplot(
      data['price'],
      labels = ['price']
  )
  ax4.boxplot(
          data['x'],
          labels = ['x']
  )
  ax5.boxplot(
          data['y'],
          labels = ['y']
  )
  ax6.boxplot(
          data['z'],
          labels = ['z']
  )

  ax1.set_title('Depth Boxplot' , size = 10)
  ax2.set_title('Table Boxplot' , size = 10)
  ax3.set_title('Price Boxplot' , size = 10)
  ax4.set_title('X,Y,Z Boxplot' , size = 10)
  ax5.set_title('X,Y,Z Boxplot' , size = 10)
  ax6.set_title('X,Y,Z Boxplot' , size = 10)
  plt.show()

def draw_violin_plot_ordered(data, column_name):
  # 그래프용 좋음-나쁨 순서 
  cut_order = [ "Ideal" , "Premium" , "Very Good" , "Good", "Fair"]
  color_order = ["D","E","F","G", "H", "I", "J"]
  clarity_order = ["IF", "VVS1", "VVS2" , "VS1" , "VS2" , "SI1" , "SI2", "I1"]

  fig = plt.figure(figsize=(24,8))
  ax1 = fig.add_subplot(1,3,1)
  ax2 = fig.add_subplot(1,3,2)
  ax3 = fig.add_subplot(1,3,3)

  sns.violinplot(
      'cut',
      column_name,
      data=data,
      order= cut_order,
      ax=ax1,
      palette= 'Set2_r',
  )
  sns.violinplot(
      'clarity',
      column_name,
      data=data,
      order=clarity_order,
      ax=ax2,
      palette= 'Set2',
  )

  sns.violinplot(
      'color',
      column_name,
      data=data,
      order=color_order,
      palette= 'Set3_r',
      ax=ax3,
  )

  ax1.set_title('Cut별 '+column_name+' 그래프')
  ax2.set_title('Clarity별 '+column_name+' 그래프')
  ax3.set_title('Color별 '+column_name+' 그래프')
  plt.show()