
#%%
# import using package
using CSV
using DataFrames
using Tidier

#%%
# make relative path
datapath = joinpath(pwd(), "raw_data", "CHdataset_naiive.csv")

#%%
# data loading
dat = DataFrame(CSV.File(datapath))

dat2 = @chain dat begin
    @mutate(No = as_integer(No), 
            Sex = as_integer(Sex), 
            Age = as_integer(Age), 
            BH_1 = as_float(BH_1), 
            BW_1 = as_float(BW_1), 
            BMI_1 = as_float(BMI_1))
end

first(dat2, 5)

#%%
# Basic data wrangling

## retrive names of columns
names(dat) 
## to get all of columns. Not omit
show(stdout, "text/plain", names(dat))	

## Show all columns in jupyter
show(dat[1:3, :], allcols = true)

#%%
# Select columns by regex

@chain dat begin
    @select(contains("eGFR"))
    @slice(1:5)
end

# Select columns by types
@chain dat begin
    @select(findall(col -> all(v -> v isa String31 || v isa String7, col), eachcol(dat)))
    @slice(1:5)
end

#%%
# Filtering row
# filter for condition

@chain dat2 begin
   @filter(guSmoke == 1)
   @filter(Age > mean(skipmissing(Age)))
   @slice(1:5)
end

#%%
# Mutating columns

@chain dat begin
    @mutate(No2 = as_integer(No))
    @select(No, No2)
    @slice(1:5)

end


#%% 
# save data for jdls2
using Feather

putpath = joinpath(pwd(), "processed_data", "processed_data.feather")
Feather.write(putpath, dat)