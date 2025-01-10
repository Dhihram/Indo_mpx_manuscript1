```python
%pwd
```




    'C:\\Users\\lsh2202865\\Documents\\mpox\\treetime'




```python
import os

# Change the working directory
os.chdir(r'C:\Users\lsh2202865\Documents\mpox\treetime')
```


```python
ls
```

     Volume in drive C has no label.
     Volume Serial Number is 069A-D0AF
    
     Directory of C:\Users\lsh2202865\Documents\mpox\treetime
    
    12/18/2024  08:21 AM    <DIR>          .
    12/18/2024  08:21 AM    <DIR>          ..
    12/18/2024  12:54 AM        17,747,853 aligned_fasta_sequences.fasta
    12/18/2024  08:18 AM        18,763,550 aligned_fasta_sequences2.fasta
    12/18/2024  01:01 AM             4,108 aligned_metadata.csv
    12/18/2024  08:20 AM             4,628 aligned_metadata2.csv
    12/17/2024  10:50 PM        17,177,970 asean_indo_aligned_mod.fasta
    12/17/2024  11:46 PM             5,288 mpox_asean_tempest.nwk
    12/18/2024  07:50 AM             5,170 mpox_asean_tempest3.nwk
    12/18/2024  12:05 AM             4,706 mpox_metadata.csv
    12/18/2024  08:02 AM             4,628 mpox_metadata2.csv
    12/18/2024  01:02 AM    <DIR>          mpox_timetree
    12/18/2024  12:24 AM        17,175,480 treetime_mpox.fasta
    12/18/2024  08:10 AM        18,717,140 treetime_mpox2.fasta
                  11 File(s)     89,610,521 bytes
                   3 Dir(s)  80,766,533,632 bytes free
    


```python
pip install phylo-treetime
```

    Collecting phylo-treetime
      Downloading phylo_treetime-0.11.4-py3-none-any.whl.metadata (13 kB)
    Collecting biopython!=1.77,!=1.78,>=1.67 (from phylo-treetime)
      Downloading biopython-1.84-cp312-cp312-win_amd64.whl.metadata (13 kB)
    Requirement already satisfied: numpy>=1.10.4 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from phylo-treetime) (1.26.4)
    Requirement already satisfied: pandas>=0.17.1 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from phylo-treetime) (2.2.2)
    Requirement already satisfied: scipy>=0.16.1 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from phylo-treetime) (1.13.1)
    Requirement already satisfied: matplotlib>=2.0 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from phylo-treetime) (3.8.4)
    Requirement already satisfied: contourpy>=1.0.1 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from matplotlib>=2.0->phylo-treetime) (1.2.0)
    Requirement already satisfied: cycler>=0.10 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from matplotlib>=2.0->phylo-treetime) (0.11.0)
    Requirement already satisfied: fonttools>=4.22.0 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from matplotlib>=2.0->phylo-treetime) (4.51.0)
    Requirement already satisfied: kiwisolver>=1.3.1 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from matplotlib>=2.0->phylo-treetime) (1.4.4)
    Requirement already satisfied: packaging>=20.0 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from matplotlib>=2.0->phylo-treetime) (23.2)
    Requirement already satisfied: pillow>=8 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from matplotlib>=2.0->phylo-treetime) (10.3.0)
    Requirement already satisfied: pyparsing>=2.3.1 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from matplotlib>=2.0->phylo-treetime) (3.0.9)
    Requirement already satisfied: python-dateutil>=2.7 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from matplotlib>=2.0->phylo-treetime) (2.9.0.post0)
    Requirement already satisfied: pytz>=2020.1 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from pandas>=0.17.1->phylo-treetime) (2024.1)
    Requirement already satisfied: tzdata>=2022.7 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from pandas>=0.17.1->phylo-treetime) (2023.3)
    Requirement already satisfied: six>=1.5 in c:\users\lsh2202865\appdata\local\anaconda3\lib\site-packages (from python-dateutil>=2.7->matplotlib>=2.0->phylo-treetime) (1.16.0)
    Downloading phylo_treetime-0.11.4-py3-none-any.whl (148 kB)
       ---------------------------------------- 0.0/148.4 kB ? eta -:--:--
       ---------------------------------------- 148.4/148.4 kB 8.6 MB/s eta 0:00:00
    Downloading biopython-1.84-cp312-cp312-win_amd64.whl (2.8 MB)
       ---------------------------------------- 0.0/2.8 MB ? eta -:--:--
       ---------------------------------------- 2.8/2.8 MB 59.2 MB/s eta 0:00:00
    Installing collected packages: biopython, phylo-treetime
    Successfully installed biopython-1.84 phylo-treetime-0.11.4
    Note: you may need to restart the kernel to use updated packages.
    


```python
!treetime --tree mpox_asean_tempest3.nwk --dates aligned_metadata2.csv --aln aligned_fasta_sequences2.fasta --outdir mpox_timetree2
```

    
    Attempting to parse dates...
    	Using column 'name' as name. This needs match the taxon names in the tree!!
    	Using column 'date' as date.
    
    0.00	-TreeAnc: set-up
    
    8.68	TreeTime.reroot: with method or node: least-squares
    
    8.68	TreeTime.reroot: rerooting will ignore covariance and shared ancestry.
    
    8.74	TreeTime.reroot: with method or node: least-squares
    
    8.74	TreeTime.reroot: rerooting will ignore covariance and shared ancestry.
    
    9.51	###TreeTime.run: INITIAL ROUND
    
    11.38	TreeTime.reroot: with method or node: least-squares
    
    11.38	TreeTime.reroot: rerooting will ignore covariance and shared ancestry.
    
    11.44	###TreeTime.run: rerunning timetree after rerooting
    
    13.60	###TreeTime.run: ITERATION 1 out of 2 iterations
    
    13.60	DEPRECATION WARNING. TreeTime.resolve_polytomies: You are resolving
         	polytomies using the old 'greedy' mode. This is not well suited for large
         	polytomies. Stochastic resolution will become the default in future
         	versions. To switch now, rerun with the flag `--stochastic-resolve`. To
         	keep using the greedy method in the future, run with `--greedy-resolve`
    
    16.66	###TreeTime.run: ITERATION 2 out of 2 iterations
    
    Inferred sequence evolution model (saved as mpox_timetree2/sequence_evolution_model.txt):
    Substitution rate (mu): 1.0
    
    Equilibrium frequencies (pi_i):
      A: 0.3329
      C: 0.1631
      G: 0.1626
      T: 0.3314
      -: 0.0099
    
    Symmetrized rates from j->i (W_ij):
    	A	C	G	T	-
      A	0	0.0256	1.1081	0.0515	95.5438
      C	0.0256	0	0.0301	1.0178	30.9819
      G	1.1081	0.0301	0	0.0618	33.5082
      T	0.0515	1.0178	0.0618	0	96.1607
      -	95.5438	30.9819	33.5082	96.1607	0
    
    Actual rates from j->i (Q_ij):
    	A	C	G	T	-
      A	0	0.0085	0.3689	0.0171	31.8102
      C	0.0042	0	0.0049	0.166	5.0534
      G	0.1802	0.0049	0	0.0101	5.4491
      T	0.0171	0.3373	0.0205	0	31.8666
      -	0.9501	0.3081	0.3332	0.9562	0
    
    
    Inferred sequence evolution model (saved as mpox_timetree2/molecular_clock.txt):
    Root-Tip-Regression:
     --rate:	1.343e-05
     --r^2:  	0.04
    
    --- saved tree as 
    	 mpox_timetree2/timetree.pdf
    
    --- root-to-tip plot saved to  
    	mpox_timetree2/root_to_tip_regression.pdf
    
    --- alignment including ancestral nodes saved as  
    	 mpox_timetree2/ancestral_sequences.fasta
    
    --- saved divergence times in 
    	 mpox_timetree2/dates.tsv
    
    --- tree saved in nexus format as  
    	 mpox_timetree2/timetree.nexus
    
    --- tree saved in auspice json format as  
    	 mpox_timetree2/auspice_tree.json
    
    --- divergence tree saved in nexus format as  
    	 mpox_timetree2/divergence_tree.nexus
    
    
