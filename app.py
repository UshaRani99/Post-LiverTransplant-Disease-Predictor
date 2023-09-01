# -*- coding: utf-8 -*-
"""
Created on Mon Jun 12 02:37:55 2023

@author: 91866
"""

import numpy as np
import pickle
import pandas as pd
import streamlit as st

from PIL import Image

pickle_in = open("model.pkl","rb")
model=pickle.load(pickle_in)

def main():
    st.title("Complications Outcome")
    html_temp = """
    <div style="background-color:tomato;padding:10px">
    <h2 style="color:white;text-align:center;">Streamlit Complications Outcome ML App </h2>
    </div>
    """
    
    st.markdown(html_temp,unsafe_allow_html=True)
    R_BMI = st.text_input("R_BMI","Type Here")
    R_Diabetes = st.text_input("R_Diabetes","Type Here")
    R_Hypertension = st.text_input("R_Hypertension","Type Here")
    R_Alcohol_Abuse = st.text_input("R_Alcohol_Abuse","Type Here")
    R_Smoking = st.text_input("R_Smoking","Type Here")
    R_Lympochyte = st.text_input("R_Lympochyte","Type Here")
    R_HepatitisB = st.text_input("R_HepatitisB","Type Here")
    R_HepatitisC = st.text_input("R_HepatitisC","Type Here")
    result=""
    if st.button("Predict"):
        result=predict_note_authentification(R_BMI,R_Diabetes,R_Hypertension,R_Alcohol_Abuse,R_Smoking,R_Lympochyte,R_HepatitisB,R_HepatitisC)
        st.success('The Complication is {}'.format(result))
    if st.button("About"):
        st.text("Lets LEarn")
        st.text("Built with Streamlit")
        
        
 if __name__=='__main__':
     main()
    
    
    
    
    
    
    
    
    
    
    
    