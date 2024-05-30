import streamlit as st
import pandas as pd
import numpy as np

st.header("Sweet Streamlit App")
st.write("Dope chart showing mad skillz")
chart_data = pd.DataFrame(np.abs(np.random.randn(20, 3)), columns=["What you know", "What you think you know", "What you actually know"])

st.line_chart(chart_data)