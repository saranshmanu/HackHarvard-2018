import turicreate as turi
url = "dataset/"
data = turi.image_analysis.load_images(url)
data["foodType"] = data["path"].apply(lambda path: "Rice" if "rice" in path else "Soup")
data.save("rice_or_soup.sframe")
data.explore()