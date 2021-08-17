/*		Cleaning Data in SQL Queries	*/
-------------------------------------------------------------------------------------
--Standardize SaleDate from DateTime Format to Date Format

--ALTER TABLE NashvilleHousing
--ALTER COLUMN SaleDate Date

--Select SaleDate from PortfolioProject..NashvilleHousing
--ORDER BY SaleDate

-------------------------------------------------------------------------------------

--Populate Missing Property Address
--Noticed that for common ParcelID, the PropertyAddress is the same
--Hence after self joining the tables will copy the PropertyAddress of the same ParcelID for null PropertyAddress

--SELECT a.ParcelID, a.PropertyAddress, b.PropertyAddress, 
--isnull(a.PropertyAddress, b.PropertyAddress)
--FROM PortfolioProject..NashvilleHousing a
--JOIN PortfolioProject..NashvilleHousing b
--	on a.ParcelID = b.ParcelID
--	AND a.UniqueID <> b.UniqueID
--where a.PropertyAddress is null


--UPDATE a
--SET PropertyAddress = isnull(a.PropertyAddress, b.PropertyAddress)
--FROM PortfolioProject..NashvilleHousing a
--JOIN PortfolioProject..NashvilleHousing b
--	on a.ParcelID = b.ParcelID
--	AND a.UniqueID <> b.UniqueID
--where a.PropertyAddress is null

-----------------------------------------------------------------------------------------

--Breaking out Address into Individual columns (Address, City, Sate)
--SELECT PropertySplitAddress, PropertySplitCity, PropertySplitState  FROM PortfolioProject..NashvilleHousing

--SELECT PropertyAddress, SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) AS Address,
--SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, len(PropertyAddress)) as City
--FROM PortfolioProject..NashvilleHousing

--ALTER TABLE NashvilleHousing
--ADD PropertySplitAddress nvarchar(255)
--UPDATE NashvilleHousing
--SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1)

--ALTER TABLE NashvilleHousing
--ADD PropertySplitCity nvarchar(255)
--UPDATE NashvilleHousing
--SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, len(PropertyAddress))

--ALTER TABLE NashvilleHousing
--ADD PropertySplitState nvarchar(255)
--UPDATE NashvilleHousing
--SET PropertySplitState = PARSENAME(replace(OwnerAddress,',','.'),1) 

--UPDATE NashvilleHousing
--SET PropertySplitState = 'TN'
--Where PropertySplitCity = ' NASHVILLE'



------------Easy Way to Extract Address, City, State------------------------
--SELECT 
--PARSENAME(replace(OwnerAddress,',','.'),3) as PropertySplitAddress,
--PARSENAME(replace(OwnerAddress,',','.'),2) as PropertySplitCity,
--PARSENAME(replace(OwnerAddress,',','.'),1) as PropertySplitState
--FROM PortfolioProject..NashvilleHousing
----------------------------------------------------------------------------

--Change Y and N to Yes and No in "Sold as Vacant" Column

select distinct(SoldAsVacant), COUNT(SoldAsVacant) ---Checking how many 'Y' & 'N' are there
FROM PortfolioProject..NashvilleHousing
GROUP BY SoldAsVacant
ORDER  BY 2

UPDATE NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	When SoldAsVacant = 'N' THEN 'No'
	Else SoldAsVacant
	END

----------------------------------------------------------------------------------------

--Delete unused columns

SELECT * FROM PortfolioProject..NashvilleHousing 

ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress

--------------------------------------------------------------------------------------

