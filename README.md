# SmidaCombinatorics



An EViews add-in implementing the **SmidaCombinatorics** algorithm to generate and display all possible arrangements, permutations, and combinations of a set of distinct elements without repetition.



## Overview



**SmidaCombinatorics** is an EViews add-in designed to generate arrangements, permutations, and combinations of a set of distinct elements without repetition.



The add-in provides a graphical user interface and a command-line interface, allowing users to perform combinatorial computations directly within EViews.



The generated results are displayed in structured EViews tables and support both numeric and non-numeric input elements.



## Features



SmidaCombinatorics provides the following features:



- Generation of arrangements without repetition.

- Generation of permutations without repetition.

- Generation of combinations without repetition.

- Support for numeric and non-numeric input elements.

- Automatic detection of duplicate elements in the input set.

- Specification of the number of selected elements k.

- Generation and display of complete results in structured EViews tables.

- Graphical user interface integrated into EViews.

- Command-line execution through the EViews command window.



## Installation

The add-in package is available in two ways:

### 1. From this GitHub repository

Download the package file: 

`SmidaCombinatorics.aipz`

### 2. From the official EViews Add-ins website

The add-in package can be downloaded from: 

https://www.eviews.com/Addins/smidacombinatorics.aipz 


### Installation procedure

For both options, open the `SmidaCombinatorics.aipz` file, click **Install**, and follow the on-screen instructions.


## Usage



After installation, users can launch **SmidaCombinatorics** in two ways:



### 1. From the EViews menu



Select:



```

Add-ins → Smida's Combinatorics (Arrangements, Permutations, Combinations)

```



### 2. From the EViews command line



Type:



```

SmidaCombinatorics

```



After launching the add-in, users can:



- enter a list of distinct elements;

- select the desired combinatorial operation (Arrangement / Permutation or Combination);

- specify the number of selected elements k;

- generate and display the complete set of results.



## Running SmidaCombinatorics.prg

Users can also download `SmidaCombinatorics.prg` from this GitHub repository.

Open the file in EViews and execute it. The SmidaCombinatorics interface will be launched, allowing users to generate arrangements, permutations, and combinations.



## Mathematical Background



Let n denote the number of distinct elements in the input set and k the number of selected elements, where:



$$
1 \leq k \leq n
$$



The add-in performs three types of combinatorial calculations without repetition.



### Arrangement



An arrangement without repetition is an ordered selection of k elements chosen from a set of n distinct elements. The order of the selected elements is important.



The number of arrangements is:



$$
A_n^k=\frac{n!}{(n-k)!}
$$



### Permutation



A permutation without repetition is an ordered arrangement of all n distinct elements of a set. The order of the elements is important.



The number of permutations is:



$$
P_n=A_n^n=n!
$$



### Combination



A combination without repetition is an unordered selection of k elements chosen from a set of n distinct elements. The order of the selected elements is not important.



The number of combinations is:



$$
C_n^k=\frac{n!}{k!(n-k)!}
$$



## Examples



For a set of four elements:



```

A B C D

```



the add-in can generate:



- arrangements for a selected number of elements k;

- all permutations when k = n;

- combinations for a selected number of elements k.



The generated results are displayed in EViews tables.



## Documentation



The complete user guide is available in:



```

SmidaCombinatorics.pdf

```



## Files



The repository contains:



```

SmidaCombinatorics/
│
├── SmidaCombinatorics.aipz
├── SmidaCombinatorics.install.prg
├── SmidaCombinatorics.prg
├── SmidaCombinatorics.pdf
├── README.md
│
└── Images/

```



## Citation

If you use SmidaCombinatorics in academic work, please cite:

Smida, Houcine L. (2026).  
*SmidaCombinatorics: Combinatorics — Arrangements, Permutations, Combinations.*

Source code and documentation available at:

https://github.com/Smida-Houcine/SmidaCombinatorics 

Add-in package available at:

https://www.eviews.com/Addins/smidacombinatorics.aipz 



## Author



**Houcine L. Smida**



## License



License information is provided in the `LICENSE` file in the repository.

