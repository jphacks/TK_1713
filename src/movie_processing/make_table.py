import enum
import numpy as np
import os
from tqdm import tqdm
import pandas as pd
import re

Tool = enum.Enum("Tool", "Nabe Flypan Suihanki NotFound")

def get_tool(text):
    if "鍋" in text:
        return Tool.Nabe
    if "フライパン" in text:
        return Tool.Flypan
    if "炊飯器" in text:
        return Tool.Suihanki
    return Tool.NotFound

def isUseStove(tool):
    if tool == Tool.Nabe or tool == Tool.Flypan:
        return True
    return False

def isLeavable(tool):
    if tool == Tool.Suihanki or tool == Tool.Nabe:
        return True
    return False

def get_duration(text):
    pattern = u'\d+分'
    match = re.search(pattern, text)
    if match == None:
        return 0
    return int(text[match.start():match.end()-1])

def make_table(path):
    dirpath =  path[:-4]
    df_w = pd.DataFrame(index=[], columns=['stepNo', 'text', 'useStove', 'leavable', 'duration', 'start', 'end'])
    df_r = pd.read_csv('data/'+dirpath+'.csv')
    play = -1
    step = 0
    before_text = ""
    for i, v in df_r.iterrows():
        if v['state']*play == 1:
            continue
        if v['state'] == 1:
            text = v['text']
            if text[:5] == before_text[:5]:
                continue
            if v['time'] <= 3.0:
                continue
            before_text = text
            tool = get_tool(text)
            series = pd.Series([step, text, isUseStove(tool), isLeavable(tool),
                                get_duration(text), v['time'], 0], index=df_w.columns)
            play = 1
            continue
        if v['state'] == -1:
            series['end'] = v['time']
            play = -1
            step += 1
            df_w = df_w.append(series, ignore_index=True)
    tebledir = "table"
    if not os.path.isdir(tebledir):
        os.makedirs(tebledir)
    df_w.to_csv(tebledir+"/"+dirpath+".csv")

if __name__ == "__main__":
    files = os.listdir('data/')
    for file in tqdm(files):
        make_table(file)
